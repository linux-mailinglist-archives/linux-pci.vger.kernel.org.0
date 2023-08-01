Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0D76B54D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjHAM6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjHAM6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 08:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FFA193
        for <linux-pci@vger.kernel.org>; Tue,  1 Aug 2023 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltNwPmf0DBc3jaGW3ILIUgoOOUs5zHEnfulHMvP47V8=;
        b=Z/sLzLeAKDoWAcHNER2d7aYMY37cjRqNLmwBxLO0fyY8bwZ/cM5mo/NG0N5r4Tvvk0XKKP
        I53lcbDinJINm65dpGkznYzKAVjfF997yuobKC0Zh+Grk0nh8rQ/ZPPbj8Q3uxtlLdaYox
        rMN73i9S5LxqLKKVSXbe8O6dvxaTD+Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-4RQr1bybO32t3VOcJMV7nA-1; Tue, 01 Aug 2023 08:58:04 -0400
X-MC-Unique: 4RQr1bybO32t3VOcJMV7nA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31785455660so3129446f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Aug 2023 05:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690894682; x=1691499482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltNwPmf0DBc3jaGW3ILIUgoOOUs5zHEnfulHMvP47V8=;
        b=SYSpFC2xYD6gD/iS1lCMO4dF1CviM2bdcq0yy7coCyt1FuduAxfUOr++A0WdVejTOH
         nrH2fviAJa+aMPw8MwCr438X/uvF2NPnRDV9Atk1AzRwRYGeTTHavdb0h5hIW2nze2e0
         BCtIx0QqN+Dt8gHWqrNhquE2I+LdDVhtBq9yJSJP3L87YcH6NnclHIaSsQV1HSnddoPY
         JmX7RN0vjJkY/8FUtDnwXw+2F8CjaEjtiCUPKinov3TTQ+t/dEVRpU6kQ4Ww/Sg07NQt
         C9eDgFDdNXFybtVUGzhI8xMMOWeYiGLz5Gc+ro6L8noO/NzI27gn2NdPqJolsMv62Ik3
         ofbQ==
X-Gm-Message-State: ABy/qLYaj5RPKsO7H0hCL2J3ZShw3M0awI4zIbcnt3yu244vo4gr8sfn
        JuW+v71I3Ihy2xzebOCUi/9mVEmZmPmGVc7JVCXyEP5K2++oWYVDNekehiHGM2rM/uORqDpn61H
        i39So6BggJrdO8diCmJm+
X-Received: by 2002:adf:f40d:0:b0:317:65de:4389 with SMTP id g13-20020adff40d000000b0031765de4389mr1924147wro.61.1690894682305;
        Tue, 01 Aug 2023 05:58:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHoo11zj1dYrqOlvbGISYlbwfB8BTe7jczhVvLvrEe3m6UwQTYtrvjkuRmcyyJhcOovqeOm5A==
X-Received: by 2002:adf:f40d:0:b0:317:65de:4389 with SMTP id g13-20020adff40d000000b0031765de4389mr1924128wro.61.1690894681912;
        Tue, 01 Aug 2023 05:58:01 -0700 (PDT)
Received: from redhat.com ([2.52.21.81])
        by smtp.gmail.com with ESMTPSA id h18-20020adff192000000b003113ed02080sm15883453wro.95.2023.08.01.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:58:01 -0700 (PDT)
Date:   Tue, 1 Aug 2023 08:57:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230801085131-mutt-send-email-mst@kernel.org>
References: <20230731144418.1d9c2baf@imammedo.users.ipa.redhat.com>
 <20230731214251.GA25106@bhelgaas>
 <20230731175316-mutt-send-email-mst@kernel.org>
 <20230801115751.1e3b5578@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801115751.1e3b5578@imammedo.users.ipa.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 11:57:51AM +0200, Igor Mammedov wrote:
> On Mon, 31 Jul 2023 17:54:21 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jul 31, 2023 at 04:42:51PM -0500, Bjorn Helgaas wrote:
> > > I would expect hot-add to be handled via a Bus Check to the *parent*
> > > of a new device, so the device tree would only need to describe
> > > hardware that's present at boot.  That would mean pci_root.c would
> > > have some .notify() handler, but I don't see anything there.  
> > 
> > That has a big performance cost though - OSPM has no way to figure out
> > on which slot the new device is, so has to rescan the whole bus.
> > 
> 
> Spec says following about OSPM receiving DeviceCheck
> ACPI6.5r 5.6.6 Device Object Notifications) "
> If the device has appeared, OSPM will re-enumerate from the parent.
> If the device has disappeared, OSPM will invalidate the state of the device.
> OSPM may optimize out re-enumeration.
> ...
> If the device is a bridge, OSPM _may_ re-enumerate the bridge and the child bus.
> "
> The later statement is was added somewhere after 1.0b spec.
> 
> According to debug logs when I was testing that hotplug still works
> I saw 're-enumerate from the parent', behavior.
> So there is space
> to optimize if there would be demand for that.

Yes I was talking about unplug.

> And 6.5 spec
> has 'Device Light Check', though using that would require some
> ugly juggling with checking supported revisions & co which were
> never reliable in practice.
> I don't know what Windows does in that case.
> 
> However if one has deep hierarchy, a BusCheck shall cause
> expensive deep scan. While for DeviceCheck it's optional 'may',
> and even that may is vague enough that one can read it as
> if it's 'a new bridge' then scan behind it while one can ignore
> existing bridge if it isn't DeviceCheck target.

And it's very clear that it's more efficient for removal.

> Regardless of that we can't just switch to BusCheck exclusively
> without harming existing setups which can legitimately use both
> methods.

-- 
MST

