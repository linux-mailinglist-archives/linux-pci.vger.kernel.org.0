Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECEC588859
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 09:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiHCH5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 03:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiHCH5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 03:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1C9129C90
        for <linux-pci@vger.kernel.org>; Wed,  3 Aug 2022 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659513470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OEFsmwkVi669wYEes65YKb6PZlH2lsPyfB4kF4NfeRE=;
        b=YBSUKuUq3Xlsha77mUJKXW5KwMdllETzhNfjIf0+juGcREgDFZoUF3RekuA+S9tKChQsco
        oRPZ/A/HdrAf9gpTdx2OeAnXAL0C7SNilaba4j/XueTm+aGNRK0Oqntv2qykzNXLqgzyyy
        AwwlgkwSgymDR4gK31skRWXjLlMwTgI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-PpgsgZ-LNtepI3SZnUDDTQ-1; Wed, 03 Aug 2022 03:57:49 -0400
X-MC-Unique: PpgsgZ-LNtepI3SZnUDDTQ-1
Received: by mail-lj1-f200.google.com with SMTP id k1-20020a2e9201000000b0025dd56bd7a4so4022225ljg.17
        for <linux-pci@vger.kernel.org>; Wed, 03 Aug 2022 00:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEFsmwkVi669wYEes65YKb6PZlH2lsPyfB4kF4NfeRE=;
        b=bQVA/G1SO3Vv5bY2Uvy5l6JUG8aaare0D28NDCGn5QsiNrH2KQzvUUJAEJw2X20eEP
         RnBjiy3slMvkVlM2efB7Gzjdceht+srJyaAIEVjJ4SCv1aXhZM+Qy+DG4f463DPPLZxz
         5B5pis0oL8P4vJ5nCEoJeG0U3Y9BCX2etEOx/eveUBLxENQL+FUZibm9KqAyv4T3ryW6
         XsMqCa+QPsMjiB9ed/VgIN9a/8grQtXbx7KZEIHe6VPuUzACVPCurCfIoXrD3iCQ6lRF
         76Hjamayn7ScuVwOkf+7DRq8RoBJqiqOVuYU3K4Yec3dFfRG0JXnoZJcTLlhqlgnBYtE
         p/fw==
X-Gm-Message-State: ACgBeo2CbunFHMhTdpOVX0AtAh4kVIP0Sjoh1REnvOW1DIYdpt8ka7vX
        CEbzKC5iTN0+MZkXn3lI/dkbvZAPfkxysUT4eEaru/TL6MyrK/Ge5IyIprER8m+t5AT2BEIs25y
        n1K8VFnrTTRg6yTokPiJngv3ccln9D5n3smga
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id t16-20020ac243b0000000b0048b01ebd1e5mr4033027lfl.641.1659513468092;
        Wed, 03 Aug 2022 00:57:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR600ldUB8qbBwa7CANdnj6UO9/ZbaTlVrEpGYh1sEEV3xqsMglefFL6pbFFalSJdNMSIfi9UKtLwl2x+Q35u4E=
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr4033015lfl.641.1659513467888; Wed, 03
 Aug 2022 00:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <165719918216.28149.7678451615870416505.stgit@palantir17.mph.net>
 <20220707155500.GA305857@bhelgaas> <Yswn7p+OWODbT7AR@gmail.com>
 <20220711114806.2724b349@kernel.org> <Ys6E4fvoufokIFqk@gmail.com>
 <20220713114804.11c7517e@kernel.org> <Ys/+vCNAfh/AKuJv@gmail.com> <20220714090500.356846ea@kernel.org>
In-Reply-To: <20220714090500.356846ea@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 3 Aug 2022 15:57:34 +0800
Message-ID: <CACGkMEt1qLsSf2Stn1YveW-HaDByiYFdCTzdsKESypKNbF=eTg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] sfc: Add EF100 BAR config support
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Martin Habets <habetsm.xilinx@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        davem <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>, ecree.xilinx@gmail.com,
        linux-pci@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        mst <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 12:05 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 14 Jul 2022 12:32:12 +0100 Martin Habets wrote:
> > > Okay. Indeed, we could easily bolt something onto devlink, I'd think
> > > but I don't know the space enough to push for one solution over
> > > another.
> > >
> > > Please try to document the problem and the solution... somewhere, tho.
> > > Otherwise the chances that the next vendor with this problem follows
> > > the same approach fall from low to none.
> >
> > Yeah, good point. The obvious thing would be to create a
> >  Documentation/networking/device_drivers/ethernet/sfc/sfc/rst
> > Is that generic enough for other vendors to find out, or there a better place?
>
> Documentation/vdpa.rst ? I don't see any kernel level notes on
> implementing vDPA perhaps virt folks can suggest something.

Not sure, since it's not a vDPA general thing but a vendor/parent
specific thing.

Or maybe Documentation/vdpa/sfc ?

Thanks

> I don't think people would be looking into driver-specific docs
> when trying to implement an interface, so sfc is not a great option
> IMHO.
>
> > I can do a follow-up patch for this.
>
> Let's make it part of the same series.
>

