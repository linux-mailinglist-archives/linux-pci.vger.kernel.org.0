Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D414AA422
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 00:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377883AbiBDXRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 18:17:05 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:48910 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiBDXRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 18:17:05 -0500
Received: from [172.20.1.124] (50-233-66-22-static.hfc.comcastbusiness.net [50.233.66.22])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JrBJH1BySz2q8Y;
        Fri,  4 Feb 2022 18:17:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1644016624; bh=nTN4J6gLwOwjvwUgWB10d7EMo0zm9tPlaYTEXfi+uA0=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=e/KfhQaLRIsGDx5g8CpP1pkGEqn1V+11n09TsP18xTFN05KK7kIWdlHPwpaTrnlIp
         P9WCkXLct3N2Aq6h7noHqXjgeO8dcVRXLFeYcTsK0xXDKZJJNuzwhDIw19S2hVBKXT
         nx0gjMaRig4dOfTZuhSinSaDXOxdjeuWXLB3zH5k=
Date:   Fri, 4 Feb 2022 15:17:02 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
In-Reply-To: <20220204230234.GA226601@bhelgaas>
Message-ID: <7b377c19-23-6793-5e43-b757cfd8437@panix.com>
References: <20220204230234.GA226601@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 4 Feb 2022, Bjorn Helgaas wrote:

> Do we have a theory on what might have caused the regression before?
> Or at least something that is different this time around?

If you'd like, I could try re-applying the previous problem commit or your
attempted fix on top of Linus' master if you'd like to see if something was
fixed somewhere else in the PCIe subsystem, but if you think it's not worth-
while I'm satisfied with the current fix (or probably more-exactly for my
particular machine, lack of regression).

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
