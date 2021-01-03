Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8777A2E8B34
	for <lists+linux-pci@lfdr.de>; Sun,  3 Jan 2021 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbhACGqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Jan 2021 01:46:03 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19748 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbhACGqD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jan 2021 01:46:03 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff168030000>; Sat, 02 Jan 2021 22:45:23 -0800
Received: from [10.25.98.34] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 3 Jan
 2021 06:45:21 +0000
Subject: Re: Are AER corrected errors worrying?
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        <linux-pci@vger.kernel.org>
References: <20210102170303.m555l4fmv3ht76yo@function>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <a38228d6-c788-e6c3-ea52-df7c9f519ecc@nvidia.com>
Date:   Sun, 3 Jan 2021 12:15:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210102170303.m555l4fmv3ht76yo@function>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1609656323; bh=TBhZGvfJGCSKjQgbiLaD+JlTkdBer8cUV/I8+YeRoS0=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=CHNVhAMaPIWX08qWIsPNCMAec2L+3JTdezDyt4H5AmVMiuGHogCCBDA2AnfwSReCW
         f1Tz7sNJiY6uW6cMl+dYagYlvZEDAmVc6dG402k/amtiNIwgH5Oc0yddg4r7kfFhmr
         7sy2v2oY0zFdXro4YbYMNhcPZhzTElk5L714aCmc1D9uzK0p7qG0YiNvu/82c9FT38
         kUB1dPSMuZ4oIeN4EVCKyqX7N+FtPFdWQUlMxnD+IX3DZHdz1h8qqKo24mSCDShqdV
         QKQbPVvKMozuqZabVll+dnizMe6tExnUJlenqneAQudVFUTO/JARbQr+8jmaujZcbH
         2/8LpNnMzEt9g==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Is it possible to share the output of 'sudo lspci -vv'?
Since this is a laptop, I'm suspecting that ASPM states might have been 
enabled which could be causing these errors.
Using 'pci=noaer' only suppresses the errors, but I feel it is better to 
root cause the issue and understand the reasons better.

- Vidya Sagar

On 1/2/2021 10:33 PM, Samuel Thibault wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> Our lab has bought a new Dell Latitude 5410 laptop, I installed debian
> bullseye on it with kernel 5.9.0-5-amd64, but it is spitting these
> errors now and then (sometimes a dozen per a minute):
> 
> Jan  1 23:30:53 begin kernel: [   46.675818] pcieport 0000:00:1d.0: AER: Corrected error received: 0000:02:00.0
> Jan  1 23:30:53 begin kernel: [   46.675933] nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> Jan  1 23:30:53 begin kernel: [   46.676048] nvme 0000:02:00.0:   device [15b7:5006] error status/mask=00000001/0000e000
> Jan  1 23:30:53 begin kernel: [   46.676140] nvme 0000:02:00.0:    [ 0] RxErr
> 
> Since it's corrected it's not actually an issue, but how worrying is it
> to see such errors on new hardware? Documentation/PCI/pcieaer-howto.rst
> is not commenting whether we are really supposed to see some of them. I
> see forums telling to use pci=noaer to stop the error logging, but is
> that really something to do?
> 
> Samuel
> 
