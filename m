Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803A92E9F9B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 22:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhADVhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 16:37:35 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:39924 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhADVhf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 16:37:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 01E663A8;
        Mon,  4 Jan 2021 22:36:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nxTrKyMHSvw3; Mon,  4 Jan 2021 22:36:50 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 39DE0BE;
        Mon,  4 Jan 2021 22:36:50 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kwXWz-000Mqb-07; Mon, 04 Jan 2021 22:36:49 +0100
Date:   Mon, 4 Jan 2021 22:36:48 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210104213648.enkuq5e2o6adbiur@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
 <20210104201247.5k47gueib3cw4sfr@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104201247.5k47gueib3cw4sfr@function>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Samuel Thibault, le lun. 04 janv. 2021 21:12:47 +0100, a ecrit:
> Vidya Sagar wrote:
> > Since this is a laptop, I'm suspecting that ASPM states might have
> > been enabled which could be causing these errors.
> 
> Keith Busch, le lun. 04 janv. 2021 10:44:35 -0800, a ecrit:
> > Sometimes these types of errors occur from low power settings, so you
> > can try disabling the automatic management of these (assuming the
> > hardware supports it). To disable nvme specific power state transitions,
> > the kernel parameter is "nvme_core.default_ps_max_latency_us=0".
> 
> I have tried to add it,
> 
> I'll watch in the coming
> hours/days to see if that avoided the issue.

I did get one

Jan  4 22:34:53 begin kernel: [ 7165.207562] pcieport 0000:00:1d.0: AER: Corrected error received: 0000:02:00.0
Jan  4 22:34:53 begin kernel: [ 7165.213891] nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
Jan  4 22:34:53 begin kernel: [ 7165.216949] nvme 0000:02:00.0:   device [15b7:5006] error status/mask=00000001/0000e000
Jan  4 22:34:53 begin kernel: [ 7165.219995] nvme 0000:02:00.0:    [ 0] RxErr

> > PCI also has automatic link power savings that you can disable with
> > parameter "pcie_aspm=off".
> 
> I'll try that if I still see errors with the nvme_core parameter.

I'm on it.

Samuel
