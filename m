Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73EE2EC5E3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 22:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbhAFVsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 16:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbhAFVsw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 16:48:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C84DA2313A;
        Wed,  6 Jan 2021 21:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609969691;
        bh=91/Aa98h8TuAYSiseznI0xMKY2ksHk8wwEYUs1TmWBA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=TB4UJMTwlEbyEZimdtXeo88/zeLItuFtUNA9BkImKyObE5keU+fu/mISceNCZE72h
         UAHrHpbNBctsQ5DL32gByjPTz/SuCjEvlu8uJyFTukb+sLFcmOnm4662wsSvRGDu/y
         P00JZbNLXU+Fgs8llYwHUnE+2NdO+ktdkB262U6zDK3bSb+q+UAa0KYGg4BBVSdJvE
         PiSsKiABtVZ12CiZD5PGbhok8rHisCIFNNN+mz/irrMomOVUqHBD99RngPnb16yYuJ
         OCSXdBSNjkW1myRjAaYIcpW7T3yiY0tyEr1DUReJZwtVtAzcDfXq0A5KPstCHhscO+
         qfI9tK2NoNLew==
Date:   Wed, 6 Jan 2021 13:48:08 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210106214808.GA1280721@dhcp-10-100-145-180.wdc.com>
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
 <20210104201247.5k47gueib3cw4sfr@function>
 <20210104213648.enkuq5e2o6adbiur@function>
 <20210106202823.ehdkno3inlzszqtb@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106202823.ehdkno3inlzszqtb@function>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 06, 2021 at 09:28:23PM +0100, Samuel Thibault wrote:
> Samuel Thibault, le lun. 04 janv. 2021 22:36:48 +0100, a ecrit:
> > Samuel Thibault, le lun. 04 janv. 2021 21:12:47 +0100, a ecrit:
> > > Vidya Sagar wrote:
> > > > Since this is a laptop, I'm suspecting that ASPM states might have
> > > > been enabled which could be causing these errors.
> > > 
> > > Keith Busch, le lun. 04 janv. 2021 10:44:35 -0800, a ecrit:
> > > > Sometimes these types of errors occur from low power settings, so you
> > > > can try disabling the automatic management of these (assuming the
> > > > hardware supports it). To disable nvme specific power state transitions,
> > > > the kernel parameter is "nvme_core.default_ps_max_latency_us=0".
> > > 
> > > I have tried to add it,
> > > 
> > > I'll watch in the coming
> > > hours/days to see if that avoided the issue.
> > 
> > I did get one
> > 
> > Jan  4 22:34:53 begin kernel: [ 7165.207562] pcieport 0000:00:1d.0: AER: Corrected error received: 0000:02:00.0
> > Jan  4 22:34:53 begin kernel: [ 7165.213891] nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> > Jan  4 22:34:53 begin kernel: [ 7165.216949] nvme 0000:02:00.0:   device [15b7:5006] error status/mask=00000001/0000e000
> > Jan  4 22:34:53 begin kernel: [ 7165.219995] nvme 0000:02:00.0:    [ 0] RxErr
> > 
> > > > PCI also has automatic link power savings that you can disable with
> > > > parameter "pcie_aspm=off".
> > > 
> > > I'll try that if I still see errors with the nvme_core parameter.
> > 
> > I'm on it.
> 
> I tried to make the machine only run apt-get update every 10m for 24h.
> 
> With pcie_aspm=off, I didn't get any corrected error
> Without it I got 39 corrected errors
> 
> So that seems very relevant :)
> 
> Is there more I can provide to investigate if that can somehow be fixed
> in the driver? I guess I can safely use the system with pcie_aspm=off?
> (the energy saving seems neglectible)

I don't think there's more to do from the kernel or driver beyond
disabling usage of the problematic feature. I think a proper fix would
have to come from the hardware vendor.
