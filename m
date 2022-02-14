Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3994B55F2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 17:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356273AbiBNQTf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 11:19:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356271AbiBNQTc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 11:19:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A59D5FF0B;
        Mon, 14 Feb 2022 08:19:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31AD0614B9;
        Mon, 14 Feb 2022 16:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D2AC340E9;
        Mon, 14 Feb 2022 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644855560;
        bh=th0fXVELAWxtqvQc+7VEAegBNHdOQZZG+5CClQGCCpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bqYjuZS4Gx1PswtxTOd7iMkJKhY53kJsJKAhg3zt1mqrw54HrKBm/UFSojXyU55BV
         n2IHZqNGpVtPu4xxLMSmjecC6c/FoNBVl0rscVcnButFTqBj1y7oAym5TswVj7Q3Xx
         gwWrRRwixzJT7nQGlwsPzsRBV+0K3nIoS8O/TnqFBJZXpBQVwNTH1sBpgCoSYcatfc
         BM8JS5r3eSrB8RUvjFdB1WTU5NbI21uXLL3o5HTfdGiUYx518rPXZ7/na8IRFePVjg
         udEqaGXyBn6Rt1a4oXE3+CQaJy9y2g6zyhWeJNOe4FIEII8iy2ShWPIbwKUTdV1qFD
         /KC7vj4kNNmgg==
Date:   Mon, 14 Feb 2022 10:19:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v8 00/10] vgaarb: Rework default VGA device selection
Message-ID: <20220214161918.GA11115@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0a06a30-f479-df9f-980c-b789f0f26ce9@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 04:46:33PM +0100, Maarten Lankhorst wrote:
> Hey,
>  
> Op 31-01-2022 om 23:23 schreef Bjorn Helgaas:
> > [+to Maarten, Maxime, Thomas; beginning of thread:
> > https://lore.kernel.org/r/20220106000658.243509-1-helgaas@kernel.org]
> >
> > On Wed, Jan 05, 2022 at 06:06:48PM -0600, Bjorn Helgaas wrote:
> >> From: Bjorn Helgaas <bhelgaas@google.com>
> >>
> >> Current default VGA device selection fails in some cases because
> >> part of it is done in the vga_arb_device_init() subsys_initcall,
> >> and some arches enumerate PCI devices in pcibios_init(), which
> >> runs *after* that.
> >
> > Where are we at with this series?  Is there anything I can do to
> > move it forward?
> 
> I'm afraid that I don't understand the vga arbiter or the vga code
> well enough to review.
> 
> Could you perhaps find someone who could review?
> 
> I see Chen wrote some patches and tested, so perhaps they could?

Hi Maarten,

Huacai Chen did provide his Reviewed-by (although as he noted, the
content initially came from him anyway and my contribution was mainly
rearranging things into separate patches for each specific case).

Anything else we can to do help here?

Bjorn
