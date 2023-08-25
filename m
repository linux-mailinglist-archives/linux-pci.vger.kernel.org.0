Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2B788635
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbjHYLod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243863AbjHYLoU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 07:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4901FF7
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692963808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yK2aJ/cxFzTH60S+l1UWL+t/xPmgIFhT2EXCNNWwwqA=;
        b=IyWG6rS24Sf2oywlW6k9wBa+Tjek7fDsJl+aMh5Z5dKC2pAA0075udAsWeMz1HMS3X7bf7
        MVEmB8WNZXu1o///nuToF8JBuABIppoGB7OjZuhH5FslQYV4r6u3vGqPV0+ljDyvXi8U3S
        Fs2E0bLHrWvRoSY0jI79voHNDjzuBks=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-GJz5qGfONe2Y8KU2AHYgJg-1; Fri, 25 Aug 2023 07:43:27 -0400
X-MC-Unique: GJz5qGfONe2Y8KU2AHYgJg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a9a8feaf7eso529292b6e.2
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 04:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692963806; x=1693568606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK2aJ/cxFzTH60S+l1UWL+t/xPmgIFhT2EXCNNWwwqA=;
        b=VdTJWVLJXE1R0lYvHeb4IsIvvPtSeu1ikH9e/Wv/qFOhi8UMFhfS1tdgrn6pd1s6um
         ANE61H/QK7bwu04o4z/JOkJuOibzUnwRYu54efhHfOTlV89Q2RuQWLd7ZuPEZasBFnD+
         rZIx8KVvRB22esj0VXW9cILu/fdoPIrVpVIRrWQVipQ/+nzNexuo9ZxV9mpwxIe9grla
         EKZfaIdZ8h7nKvvXnJaiSbtNp+44quGzshFJhtqvvBh7hLjlrIeSyDx/mm3OxCBDxxCU
         HLo6kM1RiuiiIVjEPx3zOn9wxHbcmCNwrCpDMF0DCsrCMnjW1FS3aHTSzC4lj/Sp/mEt
         K41A==
X-Gm-Message-State: AOJu0YzQaQ0TBCyi71tkL2AqAdpvkqAOEOJnu6pA8fp4FJ2Es9BrPkK5
        UW5HMfw4ASuQPwnQPsTCG70dfs87cLJocH9I4tlwVYV+B0+/ZYIE2+1INrSz+5TyZxoognx1XID
        M47AmSytwiJm9Jpmm3HvvJJjwYVXsL4Omy5c=
X-Received: by 2002:aca:2315:0:b0:3a7:55f2:552d with SMTP id e21-20020aca2315000000b003a755f2552dmr2288551oie.58.1692963806343;
        Fri, 25 Aug 2023 04:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+xJ5q9lkDG0Kt/Qn4o5FYDLr4miNIx8Cg7jyKqQ/ConFqjLbuMWXf8VkN8weihHm3wZiN+2PbsDpxFO+pGs8=
X-Received: by 2002:aca:2315:0:b0:3a7:55f2:552d with SMTP id
 e21-20020aca2315000000b003a755f2552dmr2288546oie.58.1692963806182; Fri, 25
 Aug 2023 04:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com> <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
 <20230823074447.GR3465@black.fi.intel.com> <20230823075649.GS3465@black.fi.intel.com>
 <CA+cBOTco17b_8ZMhU8gXy8z2mtZXvVxrEUdKaAuZMhyFYC3yeQ@mail.gmail.com>
 <20230823090525.GT3465@black.fi.intel.com> <CA+cBOTeOSBkw_-AM6desmdVQjTXUZbKppK_PDiOM3sXQW5QKiA@mail.gmail.com>
 <20230824114300.GU3465@black.fi.intel.com> <CA+cBOTej22hWEFvMOnFfKy16tuzS_+S7kccPPYXNoGVbYMoEdA@mail.gmail.com>
 <20230825094646.GC3465@black.fi.intel.com>
In-Reply-To: <20230825094646.GC3465@black.fi.intel.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Fri, 25 Aug 2023 13:42:59 +0200
Message-ID: <CA+cBOTeaizTbPibweo3u0zSrY_jNsbttidhUD7OQgHZ5xUB=TA@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 11:46=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I would start by contacting Lenovo because I suspect this is Thunderbolt
> firmware (host side not dock) issue so they may pull a newer one for
> this one from Intel.

Thanks. For anyone who wants to follow this, I did that in my
downstream bug report here:
https://bugzilla.redhat.com/show_bug.cgi?id=3D2230357#c23

Thanks again for all your help.
Kamil P=C3=A1ral

