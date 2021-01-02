Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A192E8811
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jan 2021 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbhABREc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Jan 2021 12:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbhABREb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jan 2021 12:04:31 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4079FC061573
        for <linux-pci@vger.kernel.org>; Sat,  2 Jan 2021 09:03:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 5CE5C479
        for <linux-pci@vger.kernel.org>; Sat,  2 Jan 2021 18:03:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wvqHG9DPSrBV for <linux-pci@vger.kernel.org>;
        Sat,  2 Jan 2021 18:03:04 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id A48AA331
        for <linux-pci@vger.kernel.org>; Sat,  2 Jan 2021 18:03:04 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kvkIx-00B2qa-Ea
        for linux-pci@vger.kernel.org; Sat, 02 Jan 2021 18:03:03 +0100
Date:   Sat, 2 Jan 2021 18:03:03 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     linux-pci@vger.kernel.org
Subject: Are AER corrected errors worrying?
Message-ID: <20210102170303.m555l4fmv3ht76yo@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-pci@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Our lab has bought a new Dell Latitude 5410 laptop, I installed debian
bullseye on it with kernel 5.9.0-5-amd64, but it is spitting these
errors now and then (sometimes a dozen per a minute):

Jan  1 23:30:53 begin kernel: [   46.675818] pcieport 0000:00:1d.0: AER: Corrected error received: 0000:02:00.0
Jan  1 23:30:53 begin kernel: [   46.675933] nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
Jan  1 23:30:53 begin kernel: [   46.676048] nvme 0000:02:00.0:   device [15b7:5006] error status/mask=00000001/0000e000
Jan  1 23:30:53 begin kernel: [   46.676140] nvme 0000:02:00.0:    [ 0] RxErr

Since it's corrected it's not actually an issue, but how worrying is it
to see such errors on new hardware? Documentation/PCI/pcieaer-howto.rst
is not commenting whether we are really supposed to see some of them. I
see forums telling to use pci=noaer to stop the error logging, but is
that really something to do?

Samuel
