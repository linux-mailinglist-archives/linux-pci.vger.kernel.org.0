Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6187E6C0A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 06:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfJ1FlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 01:41:09 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18184 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfJ1FlJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 01:41:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db67f7c0000>; Sun, 27 Oct 2019 22:41:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 27 Oct 2019 22:41:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 27 Oct 2019 22:41:08 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 05:41:08 +0000
Received: from [10.25.72.172] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 05:41:07 +0000
Subject: Re: Drop Kconfig option PCIEASPM?
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1f784101-fe7a-becf-d855-ddc6d03a3f92@gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d1c3ca5b-563a-6823-fb78-3f1853bc956e@nvidia.com>
Date:   Mon, 28 Oct 2019 11:11:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1f784101-fe7a-becf-d855-ddc6d03a3f92@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572241276; bh=i5UFvlpqqoYzHFbKbNi2NCEEOQ3pe7SLL8pmqK4WyQ4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=j7LeR1P2xGL+Q0ibCAGevO6HstiBImisroqHbkqhHU0D2nHBqklkQOrepP+gpywSw
         VDVlq/gxuBjqCQxyiXOIUEYPLVwlc0HDO1eZp609Brz51wd5lzpPnoj/QMaPQ91Wum
         ZwcQwoOrRRMfwwpP0Vwrl0/WQSOZrEWvw1fyi8Eqn6Wovef1B13wAR3ydMvwflRz8M
         t3f9YQDTPjdnT4mSL3Y8QC/fs2U7xXnpVZYMmiHXFgwmMNGtZZjMXXyKCRTiMvvc8w
         VAIWfit+ubi4gdESbVNwMgp4q4XRipPQcMIrvdYPbgDl9tiIFXBU3PWkMxRehNFmhH
         gmISZT5+oa+bQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/26/2019 3:12 AM, Heiner Kallweit wrote:
> I wonder whether anybody actually wants to disable ASPM support.
> In an old Kconfig commit message is mentioned that it may help
> to reduce kernel size of embedded systems. However I would
> think that on embedded systems ASPM is quite useful as it
> saves significant power and may result in a lower system
> temperature therefore.
> W/o ASPM support we have to live with devices coming up
> in whatever mode boot loader or firmware configure.
> 
> Heiner
> 
It means that we can still have an option to specify one of
PCIEASPM_DEFAULT/PERFORMANCE/POWERSAVE/POWER_SUPERSAVE configs right?

Vidya Sagar
