Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9016B5E0E
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 17:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCKQqL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 11:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCKQqK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 11:46:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC54532E4E
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 08:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 689F0B801BC
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 16:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3592FC433D2;
        Sat, 11 Mar 2023 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678553166;
        bh=6u411eM681dURzAqkgbsuc60q6pBsWl+2a9dkuzX0Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmFf5FXysXFGo+K79Qy+X9lKSNEKwNn0BER3/Yb46ROgsqKaHLG13LODcqLqM6J64
         CKvsggKyMJB0mtVuJfR31ofb400VIShc24osnRgzqKKiUiEbOrUOEFbbOYZx8YbnRn
         Hh96mm1++q+9b2wYOQjVnGSaXe+BXAJXwVqMUXtd6XMnbeUxMVywR5T2WRA98cTj/Z
         1H9FgHlc1AxayTqvjq0cQxctP0p1IQadAKlxsuEHkTYlHMI933YPvLY9zYbyej6F1Y
         lrsZXZDd1Bgv7ok+JVPWKG9mRFcj87VfyjEH6ctUajh1BEQn9SvA0Yxf57iqsiqE/1
         vCmADlMW6ZJsQ==
Date:   Sat, 11 Mar 2023 09:46:03 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Tushar Dave <tdave@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Message-ID: <ZAywS5Y3wrNNT0Pf@kbusch-mbp.dhcp.thefacebook.com>
References: <20230309175321.GA1151233@bhelgaas>
 <843e2392-9ff0-2286-5f97-659831013c2e@nvidia.com>
 <20230310235306.GA1290793@bhelgaas>
 <4922cec7-ecc1-4971-75af-cdbaeaa6434f@nvidia.com>
 <20230311082220.GA3649@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311082220.GA3649@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 11, 2023 at 09:22:20AM +0100, Lukas Wunner wrote:
> >   - Switch and NVMe MPS are 512B
> >   - NVMe config space saved (including MPS=512B)
> >   - You change Switch MPS to 128B
> >   - NVMe does DMA with payload > 128B
> >   - Switch reports Malformed TLP because TLP is larger than its MPS
> >   - Recovery resets NVMe, which sets MPS to the default of 128B
> >   - nvme_slot_reset() restores NVMe config space (MPS is now 512B)
> >   - Subsequent NVMe DMA with payload > 128B repeats cycle
> 
> Forgive my ignorance, but if MPS is restored to 512B by nvme_slot_reset(),
> shouldn't the communication with the device just work again from that
> point on?

The upstream port was tuned down 128 without coordinating with the kernel, so
restoring the nvme to 512 creates the mismatch.
