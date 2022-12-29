Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD95B659273
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 23:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiL2W2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 17:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2W2i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 17:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FCE7679
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 14:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672352872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHbnoPEKbPMw3NITOja3/J1RVGN2ZoCb1fhOFa94LW4=;
        b=QALd6T2BfZ0l5w2iOeeDgkEjfOjJRGUxhvPojbJMjGRHgddpm66qXYoqX/ZhyXn2fivFrk
        Sqxy0MntHqY580RG/Aa4iAdx3QTv6J+1h/yTKAG/fChfpWXDbFFmRs5KZTDFDPIt0ZJS4V
        u3U9/LGrD6EGsFll6zGM+g2v0i79bfE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-qpdPmxa4N0annPgHvVO6lA-1; Thu, 29 Dec 2022 17:27:50 -0500
X-MC-Unique: qpdPmxa4N0annPgHvVO6lA-1
Received: by mail-qt1-f200.google.com with SMTP id fp22-20020a05622a509600b003ab920c4c89so3500036qtb.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 14:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHbnoPEKbPMw3NITOja3/J1RVGN2ZoCb1fhOFa94LW4=;
        b=Dfb+e+0/lQvuwuYvWOt37M0+DvDcDz9fFTdqx6xBI/vimbMBLCXT1GncYdHCzpwLrf
         jeRUgBCW3YYjwkD4Pmm+ohVCx1tl+GH0vL02zrPzHTKTTMXO2HtJmTCql42i8vswKsfV
         gaaqLAts1C7uzQjSNDR1lo5y0jDHhEa6TjqMey/KGQmgHM+FCmTx6sEHSsJmWt2PoqIn
         ME1wlqL7HGkL+EKRPp72aEqnfpQhmX1FT4iC9HlmEiHLlJfA/VrSbO6ti0JicCNVX9Qc
         XDkBBAy4GJSXPZKjgsYu5WgfNIRCk3UIsw4uWr5XbF+9e1orDUAqn8HW9xZyJngdOpsN
         9g0Q==
X-Gm-Message-State: AFqh2kpRMaQsyb8L1DwDu5fS/IQAsuIiLEqnpOYHdXhtCv+si+RAxCDs
        uxlmjI6eiw0hqaRVYZYr2juQ6UgRVOt5Yx3lvlW0jDzmZfhrrrajUFJXdbr8YEY9qpuc/SMBLYa
        SIPhjfpmKNfNnLrgVqvv3
X-Received: by 2002:ac8:65da:0:b0:3a9:7332:3f74 with SMTP id t26-20020ac865da000000b003a973323f74mr39481607qto.19.1672352870115;
        Thu, 29 Dec 2022 14:27:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvl1146S1SoqnZLGbNKPU35QzmMmqiJgwLqeEadXm8SV5fx7paXucmPsv2beTTyd8SjCaMJYw==
X-Received: by 2002:ac8:65da:0:b0:3a9:7332:3f74 with SMTP id t26-20020ac865da000000b003a973323f74mr39481590qto.19.1672352869857;
        Thu, 29 Dec 2022 14:27:49 -0800 (PST)
Received: from redhat.com ([5.181.234.214])
        by smtp.gmail.com with ESMTPSA id bn35-20020a05620a2ae300b00702311aea78sm13723685qkb.82.2022.12.29.14.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 14:27:48 -0800 (PST)
Date:   Thu, 29 Dec 2022 17:27:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH 1/3] Add SolidRun vendor id
Message-ID: <20221229172715-mutt-send-email-mst@kernel.org>
References: <CAJs=3_AJnj9udpJ1LRtC+9qvo5Fw-=FjvZRqZkHCaQSEP-FyYg@mail.gmail.com>
 <20221229212906.GA631104@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229212906.GA631104@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 29, 2022 at 03:29:06PM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 29, 2022 at 11:06:02PM +0200, Alvaro Karsz wrote:
> > > On Mon, Dec 19, 2022 at 10:35:09AM +0200, Alvaro Karsz wrote:
> > > > The vendor id is used in 2 differrent source files,
> > > > the SNET vdpa driver and pci quirks.
> > >
> > > s/id/ID/                   # both in subject and commit log
> > > s/differrent/different/
> > > s/vdpa/vDPA/               # seems to be the conventional style
> > > s/pci/PCI/
> > >
> > > Make the commit log say what this patch does.
> > >
> > > > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > >
> > > With the above and the sorting fix below:
> > >
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > > ---
> > > >  include/linux/pci_ids.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > > index b362d90eb9b..33bbe3160b4 100644
> > > > --- a/include/linux/pci_ids.h
> > > > +++ b/include/linux/pci_ids.h
> > > > @@ -3115,4 +3115,6 @@
> > > >
> > > >  #define PCI_VENDOR_ID_NCUBE          0x10ff
> > > >
> > > > +#define PCI_VENDOR_ID_SOLIDRUN               0xd063
> > >
> > > Move this to the right spot so the file is sorted by vendor ID.
> > > PCI_VENDOR_ID_NCUBE, PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_XEN got
> > > added in the wrong place.
> > >
> > > >  #endif /* _LINUX_PCI_IDS_H */
> > > > --
> > 
> > Thanks for your comments.
> > 
> > The patch was taken by another maintainer (CCed)
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=afc9dcfb846bf35aa7afb160d5370ab5c75e7a70
> > 
> > So, Michael and Bjorn,
> > Do you want me to create a new version, or fix it in a follow up patch?
> > 
> > BTW, the same is true for the next patch in the series, New PCI quirk
> > for SolidRun SNET DPU
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=136dd8d8f3a0ac19f75a875e9b27b83d365a5be3
> 
> I don't know how Michael runs his tree, so it's up to him, but "New
> PCI quirk for SolidRun SNET DPU." is completely different from all the
> history and not very informative, so if it were via my tree I would
> definitely update both.
> 
> Bjorn

New version pls, I rebase so no problem to replace.

-- 
MST

