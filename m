Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862A62E9EFB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 21:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhADUmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 15:42:51 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:39684 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbhADUmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 15:42:51 -0500
X-Greylist: delayed 1628 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2021 15:42:50 EST
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 1F001573;
        Mon,  4 Jan 2021 21:15:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cnyBnM3xSoPG; Mon,  4 Jan 2021 21:14:59 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 733E5AD;
        Mon,  4 Jan 2021 21:14:59 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kwWDf-000KtD-20; Mon, 04 Jan 2021 21:12:47 +0100
Date:   Mon, 4 Jan 2021 21:12:47 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210104201247.5k47gueib3cw4sfr@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Vidya Sagar wrote:
> Since this is a laptop, I'm suspecting that ASPM states might have
> been enabled which could be causing these errors.

Keith Busch, le lun. 04 janv. 2021 10:44:35 -0800, a ecrit:
> Sometimes these types of errors occur from low power settings, so you
> can try disabling the automatic management of these (assuming the
> hardware supports it). To disable nvme specific power state transitions,
> the kernel parameter is "nvme_core.default_ps_max_latency_us=0".

I have tried to add it, and this one line changed in lspci -vv:

02:00.0 Non-Volatile memory controller: Sandisk Corp WD Black SN750 / PC SN730 NVMe SSD (prog-if 02 [NVM Express])
[...]
	Capabilities: [c0] Express (v2) Endpoint, MSI 00                                               
[...]
		DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
turned to
		DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-

that last value happens to be what I was seeing for that line with the
manufacturer-provided ubuntu linux kernel.

So far (30m uptime) no corrected error report, I'll watch in the coming
hours/days to see if that avoided the issue. I wasn't able to trigger
such corrected errors by loading the machine, so possibly that's indeed
the converse that I should have been trying: letting it go low power :)

> PCI also has automatic link power savings that you can disable with
> parameter "pcie_aspm=off".

I'll try that if I still see errors with the nvme_core parameter.

Samuel
