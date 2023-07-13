Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0CE752BA1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGMU1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 16:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjGMU1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 16:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7824F2120
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689280017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QGZtC1ouPEFJ43AdcfdvoUSGn/GVYmiSLze60QVyIlA=;
        b=X9dvG41XzPLy8Q2FsCNFx3oeL/3c8T/wgR9YmCrQGPuFor3etHglkOgIy+umFGQGYSfZOU
        u8udtTgcHL6mYzkAXHGwU9vbrLqboCYRI59v2soo6J5rB8w03Xgeg/LTLYFFmoQzm2xptW
        19v+kn37DmSC0KxCzkQyCiGoMlaNMRs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-J9_6ZJ1yPPS-QBEFEOgFPQ-1; Thu, 13 Jul 2023 16:26:56 -0400
X-MC-Unique: J9_6ZJ1yPPS-QBEFEOgFPQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7675fc3333eso85118685a.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Jul 2023 13:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280016; x=1691872016;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGZtC1ouPEFJ43AdcfdvoUSGn/GVYmiSLze60QVyIlA=;
        b=OUbqR7LD5OefjUMSrIwpgDyMMLHzUTiwH0Tu00mUywE2HAgmVsWoHneCU/CHPygUl5
         mhaevNBBwcDh7NxaqI0vEcjNR9dYWxpYgWNpic3DjpHUNZm075Dyi/1+0TPkmaqNU18L
         lVPpMcSmtbYqz4MRTPAQZBvBis4w4yTknlbGSJCAwVW4cOAQc+6d2VN05SiUKihBFTzL
         OHOpMZtPrwv5W6x+Jg5UoRGNMqQFU6/B4XbOVCe3Yp+jBS/qKTMzud++b4F4Z2EbVJ06
         qD1LVmAWSKPj9EJkCx5QFsE4FfJJNf9uYYikyHF6fKO68QzxGmBQPZD5Vk7wnXLclVGp
         hK4w==
X-Gm-Message-State: ABy/qLaUCkZNk/8TC53KH8huaLl1l+Vx+7nVCDjAMSDWMLx6d/4tvoHV
        FlqxGi8xJdGr44buIfpZJUZmEJo8QNcRUcUbRs+LApG99/fpf34cx1+/2TFpfyupZ96D1hAeTqQ
        dJ8Dntc4eYI4AmmIFY7Iv
X-Received: by 2002:a05:620a:3196:b0:767:13b:38ff with SMTP id bi22-20020a05620a319600b00767013b38ffmr938920qkb.7.1689280015829;
        Thu, 13 Jul 2023 13:26:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHajbmqTWWm13Du5Q2Vy3CK9udDFL8vxB5p2P/iWRySVPyCDXvoh/wXt9VXw4bDhAj+t07Dhg==
X-Received: by 2002:a05:620a:3196:b0:767:13b:38ff with SMTP id bi22-20020a05620a319600b00767013b38ffmr938907qkb.7.1689280015575;
        Thu, 13 Jul 2023 13:26:55 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id r4-20020a0cb284000000b006363c687cf6sm3356060qve.128.2023.07.13.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:26:55 -0700 (PDT)
Message-ID: <365dbb61921ff37862c91862d31d75fec2a51185.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
From:   Radu Rendec <rrendec@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Thu, 13 Jul 2023 16:26:53 -0400
In-Reply-To: <20230713170355.GA323073@bhelgaas>
References: <20230713170355.GA323073@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2023-07-13 at 12:03 -0500, Bjorn Helgaas wrote:
> On Thu, Jun 29, 2023 at 11:04:50PM -0400, Radu Rendec wrote:
> > On Thu, 2023-06-29 at 17:11 -0500, Bjorn Helgaas wrote:
> > ...
>=20
> > > If converting from chained to normal handlers can be done safely, I
> > > would definitely be in favor if doing it across all of drivers/pci/ a=
t
> > > once so they're all consistent.=C2=A0 Otherwise that code just gets c=
opied
> > > to new drivers, so the issue persists and spreads.
> >=20
> > I think the conversion can be done safely, meaning that it won't break
> > the drivers. And by the way, there are other IRQ drivers (outside the
> > PCI space) that use chained interrupts.
> >=20
> > Unfortunately, it seems we are going in circles. Chained interrupts are
> > bad because they let IRQ storms go unnoticed and lock up the system,
> > but converting them to regular interrupts is also bad because it breaks
> > the userspace ABI.
> >=20
> > I am willing to help clean up this mess, but I think first we need to
> > come up with a solution that's acceptable for everybody. I was hoping
> > Marc and Thomas would chime in, but unfortunately that hasn't happened
> > yet - other than each of them pointing out (separately) what is wrong
> > with each approach.
>=20
> I don't think Marc or Thomas are going to chime in with a fully-formed
> solution.=C2=A0 I think to make progress, you (or Pali, or somebody) will
> have to try to address Marc and Thomas' comments, make a proposal, and
> we can iterate on it.

That crossed my mind too. Unfortunately, Marc's and Thomas' comments
are contradictory, or at least that's my interpretation. I don't expect
them to come up with a fully-formed solution, but merely to agree upon
something that the rest of us can follow. Otherwise, I think no matter
what we may come up with, at least one of them will dismiss it. They
made very clear points, and I understand both. I just can't see a
common denominator.

Let me elaborate a bit. Thomas made it very clear that we should get
rid of chained interrupts altogether and suggested to use regular
interrupts instead. And since all regular interrupts are visible in
procfs by default, so is their affinity control interface. And with
that you can now change the affinity of a parent interrupt and it will
also affect the affinity of all child interrupts. That would break the
promise that the procfs interface currently makes, which is that
setting the affinity on an interrupt will affect *only* that particular
interrupt and nothing else (that is Marc's point).

The only solution that comes to mind is this:
 * Add support for tracking parent-child interrupt relationships.
 * Modify the existing procfs affinity control interface to reject
   changing the affinity of a parent interrupt (i.e. an interrupt that
   has at least one child interrupt associated).
 * Convert chained interrupts to regular interrupts as needed.
 * Create a new sysfs affinity control interface that allows setting
   the affinity of any interrupt, including parent interrupts.
 * Expose the parent-child interrupt relationships in sysfs, so any
   program that is aware of the new interface can go to the root
   interrupt to set the affinity.

To be honest, I think this approach would make things even messier and
more confusing than they are today. And I'm not even sure it would not
break the procfs interface backwards compatibility in a different way.

Of course, any comments or suggestions are welcome and would be
appreciated!

Best regards,
Radu

