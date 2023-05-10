Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753626FD3D1
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 04:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjEJCXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 22:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjEJCXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 22:23:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B4D26B7
        for <linux-pci@vger.kernel.org>; Tue,  9 May 2023 19:23:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64115eef620so46931101b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 09 May 2023 19:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oobak.org; s=ghs; t=1683685412; x=1686277412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8J+66V5Gk0SL0t9oUy59Xocc22qEh+YnyxHz7Db4Lo=;
        b=Q1pLRaBZ9Cp2JnSFTH7/NNBIC8mlChWigGXLAoMUSWFewpoWKqKx3LRVNFZUTHt3Oi
         1DkFZL/ENhUds0AHy2Vvewv3oRwtsQMtC25XjDc3MNbtw4Wo5OAiaiDFcVipBSOp3JGi
         ECLzXLRzSI5fZii87vMcEZyDxHjJft/um6D6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683685412; x=1686277412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8J+66V5Gk0SL0t9oUy59Xocc22qEh+YnyxHz7Db4Lo=;
        b=I8encKdyOp/+jZT5i+Oujm6lA+mVjhPggDAqtWGKzwB5YFXm4OxElOoHHtHj0gUVdr
         axAovCKACaEu22Su8R5Fhf7dD52h+h0u+1L1cgUSZYRZkPPEuO5mumv9APGmI3JOWsXp
         SYZRuEm6NU6z6zedThq8o39UvGslcvwxQPU0m8FGMbEvg5pr2lT/H0j0b9R/M99GYuI/
         PvtCf9f4czb3BWdKyvxnRKqLAwFmxCBQH5P4o7p/9KddFwjtlfDHBad/rkcrClCOlUfg
         lu6n1qYejkdzULOF6MbLn7FY1JIxj7clpIusBmBK5cZlqaeRqMlPmobSsuBn1fX2o9TL
         M5IQ==
X-Gm-Message-State: AC+VfDx8BbkKbCOjLyqvj64jhnBQw8GNrnb8hNpwXpgKhxj1gprjzKqf
        Kd+wLnEYxMowrLB9pKVXi91EjQG4TMi7A5jYIjDGOQ==
X-Google-Smtp-Source: ACHHUZ7gYbZJU3ICkzrM+hdVv0uGc8INujKB6Y2khXclJJO9aFmqsz03ebrL+QQdDEE22TvPoc8WQjDDgWF7a2ZUk48=
X-Received: by 2002:a17:902:e848:b0:1a9:5674:281c with SMTP id
 t8-20020a170902e84800b001a95674281cmr21123397plg.23.1683685411632; Tue, 09
 May 2023 19:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230507073519.9737-1-mike@oobak.org> <20230509214851.GA1277116@bhelgaas>
In-Reply-To: <20230509214851.GA1277116@bhelgaas>
From:   Mike Pastore <mike@oobak.org>
Date:   Tue, 9 May 2023 21:23:20 -0500
Message-ID: <CAP_NaWYtA65-nMXj9qpU2j-VvonKt9JT34iOt15hR1iTi11Y9A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Apply Intel NVMe quirk to Solidigm P44 Pro
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 9, 2023 at 4:48=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
> Applied with subject:
>
>   PCI: Delay after FLR of Solidigm P44 Pro NVMe
>
> to my virtualization branch for v6.5.

Thank you for testing! Should I submit a new version of the patch with
this subject line?

> I also moved PCI_VENDOR_ID_SOLIDIGM to keep pci_ids.h sorted.

Ah, the base commit I'm referencing has some unsorted lines at the
bottom, which threw me off. I can move it as well if I submit a new
version. Thank you.

Mike
