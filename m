Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68252618600
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 18:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKCRQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 13:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKCRQh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 13:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575C39C
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667495740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbGTVWdtOndpOIbnhFBmak1sKrq7boFMrksDAE5yy6Y=;
        b=JzSW5LMKhBJx6KSLzDMXiu6Cp39F5oQqaui4dehKE7TKS8T6qzb2bN71G1v6narkA2V/+e
        ZxiUC10UtoiH52tzCwqK7BgE5kb6v3e8WKlw0qd2byNMJpz23ZTtSwfXEmAFIy2z5hRwpU
        Yf3ItJ1XMEqngAOo/AdPa2MM/d1zocM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-MeSdx6dfNye-nRGXwsiOoQ-1; Thu, 03 Nov 2022 13:15:39 -0400
X-MC-Unique: MeSdx6dfNye-nRGXwsiOoQ-1
Received: by mail-io1-f72.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso1443964iob.20
        for <linux-pci@vger.kernel.org>; Thu, 03 Nov 2022 10:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbGTVWdtOndpOIbnhFBmak1sKrq7boFMrksDAE5yy6Y=;
        b=jUToF9vUf4lroPyauMd0woaVVnRNq6K5Mpjmw5wzUH+bH1JcPEaS8J4qYEt/npc1tx
         4hECQ+XGJrTmJ/89+1NnePI1GH5g1Nd34RbTipTxCHWTF/KYmkbuRgt1YqQVe0Y/VJSs
         ORoK+d55SnAomr0+Q1NnllfxxNCTtjELBD56Hmcu7x969+qJiEHV5fMzsEw3Tcm1EMFs
         SWyllAcPZYGcfoi/ICj7OBqfAXRuUbIIHW4biNF/O8WL6xUwxZ4Fvb4WRkApMQxMo7Ug
         esbJsEZ3p5tHYwwxiwk0uAlNKkZWsBrapbtRoLfz7h+hrw1An2YuXYEF2BtkFH3ipMfi
         8mBA==
X-Gm-Message-State: ACrzQf2gzv6evgsiC4t5OTfDbMq/Iq3nCuie7QQ6Mebm+a85n8RTl2Yu
        R14GShS1ae+XjlOW5TWULo23Lizmq3AKWYx5houa225MBME0d75QXXRXTmrM8E74XKQnE3VGSgN
        L54BjEOpl0knQjLoi3tsD
X-Received: by 2002:a6b:d112:0:b0:6c0:27e5:9edd with SMTP id l18-20020a6bd112000000b006c027e59eddmr19999816iob.213.1667495738384;
        Thu, 03 Nov 2022 10:15:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6wEegaemyyxLAuTD0zYNkK7CfZk7uuCoLW1ZMCMkdfEXTM2jPHnZQbM9PClEofl1SCWXc+Sw==
X-Received: by 2002:a6b:d112:0:b0:6c0:27e5:9edd with SMTP id l18-20020a6bd112000000b006c027e59eddmr19999804iob.213.1667495738058;
        Thu, 03 Nov 2022 10:15:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z26-20020a05660217da00b006cb4c036d6asm519275iox.36.2022.11.03.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:15:37 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:15:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     francisco.munoz.ruiz@linux.intel.com, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev, linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH V2] PCI: vmd: Fix secondary bus reset for Intel bridges
Message-ID: <20221103111536.3cf450fd.alex.williamson@redhat.com>
In-Reply-To: <20221102234221.GA8153@bhelgaas>
References: <20221031214501.28279-1-francisco.munoz.ruiz@linux.intel.com>
        <20221102234221.GA8153@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2 Nov 2022 18:42:21 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, Myron]
>=20
> On Mon, Oct 31, 2022 at 02:45:01PM -0700, francisco.munoz.ruiz@linux.inte=
l.com wrote:
> > From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> >=20
> > The reset was never applied in the current implementation because Intel
> > Bridges owned by VMD are parentless. Internally, pci_reset_bus applies
> > a reset to the parent of the pci device supplied as argument, but in th=
is
> > case it failed because there wasn't a parent.
> >=20
> > In more detail, this change allows the VMD driver to enumerate NVMe dev=
ices
> > in pass-through configurations when host reboots are performed. Commit =
id
> > =E2=80=9C6aab5622296b990024ee67dd7efa7d143e7558d0=E2=80=9D attempted to=
 fix this, but
> > later we discovered that the code inside pci_reset_bus wasn=E2=80=99t t=
riggering
> > secondary bus resets.  Therefore, we updated the parameters passed to
> > it, and now NVMe SSDs attached to VMD bridges are properly enumerated in
> > VT-d pass-through scenarios. =20
>=20
> Did you mean "guest reboots" above?  If the *host* reboots, I assume
> everybody (host and guests) starts over, so a reset wouldn't really
> apply.
>=20
> Is the scenario that the VMD device is passed through to a guest, and
> the guest OS is running vmd_probe() and vmd_enable_domain()?
>=20
> I thought VFIO already had something to reset devices between guests.
> But maybe this is different because from the point of view of VFIO,
> the pass-through happens only once, and during that single session,
> the guest OS reboots several times, so you want vmd_probe() to reset
> the downstream devices?
>=20
> Should this have a Fixes: tag for 6aab5622296b?
>=20
> s/pci/PCI/ above in English text.
>=20
> Also add "()" after function names.
>=20
> Use the typical 12-char SHA1 + subject citation, e.g., 6aab5622296b
> ("PCI: vmd: Clean up domain before enumeration").
>=20
> > Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> > Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index e06e9f4fc50f..34d6ba675440 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -859,8 +859,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, =
unsigned long features)
> > =20
> >  	pci_scan_child_bus(vmd->bus);
> >  	vmd_domain_reset(vmd);
> > -	list_for_each_entry(child, &vmd->bus->children, node)
> > -		pci_reset_bus(child->self);
> > +
> > +	list_for_each_entry(child, &vmd->bus->children, node) {
> > +		if (!list_empty(&child->devices)) {
> > +			pci_reset_bus(list_first_entry(&child->devices,
> > +						       struct pci_dev,
> > +						       bus_list));

Do you want to test the return value here to avoid another case of not
actually doing what we expect it to do?  WARN_ON perhaps?  Thanks,

Alex

> > +			break;
> > +		}
> > +	}
> > +
> >  	pci_assign_unassigned_bus_resources(vmd->bus);
> > =20
> >  	/*
> > --=20
> > 2.25.1
> >=20
> > Hi Bjorn,
> >=20
> > I updated the commit message with more details. Hopefully, this will=20
> > clarify its purpose.
> >=20
> > Thanks,
> > Francisco. =20
>=20

