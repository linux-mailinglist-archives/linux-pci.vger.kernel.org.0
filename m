Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26CD76A36F
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjGaVzQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 17:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjGaVzP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 17:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EDB19F
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690840468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Id3I1cJMIHoKEHxCvdzG3jxQMHabAL/BIyDQ5h52PeY=;
        b=D3qcu2oovxXfhBy2mPSWYYdjdveO47MqX4dOgK6uS6cHgrrQjjLHJlJB4SEfzBz3yuZzpT
        i+KUUH0C1nkxOhNt//bzRdilE9bW0TdN9JcI2fpB1+uZXyi+34Q/aHsdDAd1nl/AjRI+h5
        wMcsnXvIZ1gsL6vYhQ7kYl7kkURPRaA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-_VDnW7kUPQiySj99uD3-vw-1; Mon, 31 Jul 2023 17:54:26 -0400
X-MC-Unique: _VDnW7kUPQiySj99uD3-vw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31701b27d19so2464507f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 14:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840465; x=1691445265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id3I1cJMIHoKEHxCvdzG3jxQMHabAL/BIyDQ5h52PeY=;
        b=mFDzg/hBEWWp1T286Z79ivELsN1Nm99dxiJdSTg3hsnbQG3M6pYxXhWPpZFCs5fboi
         KTKySNt60ZtfA6sjw08ywXiYJPEyY+bWw+EuWLT4D+1RHuNE+JfUcxZhiCxovUfxVWgh
         JrtS4/YEs9M1bGalMo7LoY+2O7g3i0H7sddUtQSBdcMCBR2WnkZgn3wo2SOa8Q2f6kZK
         ssISRkRZVX8V8HQYGq0uVNh6PUO/bu++KEmqtoXRZ9ZdU1in7E0gkXg4Fo4anE+LiZnb
         2hkc5Ws1YQYZCJVPy7izGjiU0bUrirWVWQzkn6iQncJZSRiKUkNbxOyr7MNWc9Foriaz
         jCIg==
X-Gm-Message-State: ABy/qLZlcJ5sG+gfKkdrGPsOnYoMjJ+7+Kt7W8bnzopc3a63KR6Gec4h
        WhMfi9h2PFTeFSpH5CE4lwN/y/WeNeoBJtj2dhEWT7IlIePpg/QiDunuQgyoNkHHt72nj3gcFJW
        nBKpKUUowFOsY912Vqm69
X-Received: by 2002:a5d:6692:0:b0:314:3e96:bd7e with SMTP id l18-20020a5d6692000000b003143e96bd7emr742576wru.4.1690840465586;
        Mon, 31 Jul 2023 14:54:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEX9SucAtVs7in4FOojZQ/GuK6o+u4Hoj5NLmRuHHukOPExj5qXSjAjeXOkO4itn74lrQf+Jw==
X-Received: by 2002:a5d:6692:0:b0:314:3e96:bd7e with SMTP id l18-20020a5d6692000000b003143e96bd7emr742567wru.4.1690840465319;
        Mon, 31 Jul 2023 14:54:25 -0700 (PDT)
Received: from redhat.com ([2.52.21.81])
        by smtp.gmail.com with ESMTPSA id p3-20020a1c7403000000b003fbc9d178a8sm15014373wmc.4.2023.07.31.14.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:54:24 -0700 (PDT)
Date:   Mon, 31 Jul 2023 17:54:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230731175316-mutt-send-email-mst@kernel.org>
References: <20230731144418.1d9c2baf@imammedo.users.ipa.redhat.com>
 <20230731214251.GA25106@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731214251.GA25106@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 04:42:51PM -0500, Bjorn Helgaas wrote:
> I would expect hot-add to be handled via a Bus Check to the *parent*
> of a new device, so the device tree would only need to describe
> hardware that's present at boot.  That would mean pci_root.c would
> have some .notify() handler, but I don't see anything there.

That has a big performance cost though - OSPM has no way to figure out
on which slot the new device is, so has to rescan the whole bus.

