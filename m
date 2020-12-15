Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430542DACDE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 13:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgLOMQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 07:16:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9666 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbgLOMQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2020 07:16:50 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd8a9090000>; Tue, 15 Dec 2020 04:16:09 -0800
Received: from [10.25.97.140] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Dec
 2020 12:16:05 +0000
Subject: Re: dwc: tegra194: issue with card containing a bridge
To:     Mian Yousaf Kaukab <ykaukab@suse.de>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201215102442.GA20517@suse.de>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
Date:   Tue, 15 Dec 2020 17:45:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201215102442.GA20517@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608034569; bh=JswylNTbg6tEbVK8FYcScMuew/YP7v2/TK0pTG+zs38=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=CvxlTwfMh4x+1QRV0VC1xjaGyIBn3xZq8P4yJdEkXCXMZ5N1AxbH42RaieFvBC6TI
         8eA4hnQbdNMM0S5oeHz6hbVGqJOvTiJW/ijZ+fqG7iwcKR7dWYfwhYWL35CIN3/W8s
         +iGZCPiQiVtAMrpd/+OWE/50OhCB8jHs3kEu8J04ax0PDZf1M9PvyNv4jBXwGoWq+X
         iffmHwTNPwLvWoB1nzEEKMo0Wy0xZqjaKMnnwBFUzUEX9i7wU44NhlKzxYdn4VR+Uk
         JHt3DX+Vsy2ksF6bdzKiTNNxIVeoeDNzkFNFTdE1h57wFHPTPlZGvfpVjd0YIZBETl
         C+LcV1X5GMkiA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Mian for bringing it to our notice.
Have you tried removing the dw_pcie_setup_rc(pp); call from 
pcie-tegra194.c file on top of linux-next? and does that solve the issue?

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c 
b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5597b2a49598..1c9e9c054592 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -907,7 +907,7 @@ static void tegra_pcie_prepare_host(struct pcie_port 
*pp)
                 dw_pcie_writel_dbi(pci, 
CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
         }

-       dw_pcie_setup_rc(pp);
+       //dw_pcie_setup_rc(pp);

         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);

I took a quick look at the dw_pcie_setup_rc() implementation and I'm not 
sure why calling it second time should create any issue for the 
enumeration of devices behind a switch. Perhaps I need to spend more 
time to debug that part.
In any case, since dw_pcie_setup_rc() is already part of 
dw_pcie_host_init(), I think it can be removed from 
tegra_pcie_prepare_host() implemention.

Thanks,
Vidya Sagar

On 12/15/2020 3:54 PM, Mian Yousaf Kaukab wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi,
> I am seeing an issue with next-20201211 with USB3380[1] based PCIe card
> (vid:pid 10b5:3380) on Jetson AGX Xavier. Card doesn't show up in the
> lspci output.
> 
> In non working case (next-20201211):
> # lspci
> 0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
> 0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
> 0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)
> 
> In working case (v5.10-rc7):
> # lspci
> 0001:00:00.0 PCI bridge: Molex Incorporated Device 1ad2 (rev a1)
> 0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
> 0005:00:00.0 PCI bridge: Molex Incorporated Device 1ad0 (rev a1)
> 0005:01:00.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
> 0005:02:02.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
> 0005:03:00.0 USB controller: PLX Technology, Inc. Device 3380 (rev ab)
> # lspci -t
> -+-[0005:00]---00.0-[01-ff]----00.0-[02-03]----02.0-[03]----00.0
>   +-[0001:00]---00.0-[01-ff]----00.0
>   \-[0000:00]-
> #lspci -v
> https://paste.opensuse.org/87573209
> 
> git-bisect points to commit b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common code").
> dw_pcie_setup_rc() is not removed from pcie-tegra194.c in this commit.
> 
> Could the failure be caused because dw_pcie_setup_rc() is called twice now in case of tegra194?
> 
> BR,
> Yousaf
> 
> [1]: https://www.broadcom.com/products/pcie-switches-bridges/usb-pci/usb-controllers/usb3380
> 
