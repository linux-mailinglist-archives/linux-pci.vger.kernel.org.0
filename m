Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953776C0C5B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 09:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCTIir (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 04:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCTIiq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 04:38:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF3C177;
        Mon, 20 Mar 2023 01:38:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w4so3575019plg.9;
        Mon, 20 Mar 2023 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679301524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJC3AQ7lV8EAfEonQK8BPgGYXPUwRyy9bVVTnAJzNlE=;
        b=Q+r+wwIxMmaN2/gtgWy01jZrITAFEMqLNMeZuGydYBHdGAs6j5cgPfi9HDpisA1eqt
         HD0NYC1mLwQmrv9A/QdHHL9Xjoj5jWg+bdsoGjFBxlM83NhEKCscESdt2KGEWmbhrVpj
         RaaA7MLnqPRzMOkrcDdMoIElGn6lcr4HEoq2TMFXptrHY5tFqbHsRJ/umzEfDIjKu2MP
         /H3GDFS7HCXEtuNAHcCyhluJMULfmIhWKY462qgWfDaGtZAA922shs+8OKSFY7Jc7G+0
         FQTM8KUtejIe8W9gApZ0owD3v4P2DRlphi9YW7TGugPgcvfrlZXT8y6F+6+b3McRe2yL
         CqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679301524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJC3AQ7lV8EAfEonQK8BPgGYXPUwRyy9bVVTnAJzNlE=;
        b=BU0x86OnnhV6dHOkcEzBvf2e/kymJnjgE3vAiZmeWZ5kCYbCNzscPxmztFldGQvDFL
         N61ob8J9UXFm9DKPY4mjz7lPBSBPAAj+FQyxJsKzS5IedfHEq/ZaSIxB0MktZJY6xrqc
         n1yTVPpYmlTCZ7KdxEoJMurDu8qfQV0f+4FWnn7f+KQHolc0pf3pUnWI2AFPa54M128Z
         RUwhboICH6I1kyWTUjVw4iTTqoeoV0DpR8BRJ7sC3v88/BFxNpN/3XDyIFD9uOzx0Ovf
         xfqGc3t/r9+iiF3nms6Wfgh9QmlHkZrvZkpfQz7xF3Ks5O1XRoqvZ2hycLRLqjNiCHZT
         6uRg==
X-Gm-Message-State: AO0yUKXiZthbEDTPMELnSj4DBnpD2uEyO24TKyJPvwOrxEHR9YCATxsF
        1Mh8HAnGcpPZP2H2qb7HLOt1B8D0xhOk6FBVeK8=
X-Google-Smtp-Source: AK7set9AI/fgSRifR7ibuLz98o6z22kyg3h8QsUnojunVooC/NtabxqvOtIcPD9gQzxSGf9JhSj68Ol/aGs5ZCsC8XE=
X-Received: by 2002:a17:902:a3c7:b0:1a0:51f6:a252 with SMTP id
 q7-20020a170902a3c700b001a051f6a252mr6393901plb.3.1679301524355; Mon, 20 Mar
 2023 01:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230316122322.339316-1-korantwork@gmail.com> <44b1519b-f9e0-476a-ff47-8d21f004b3cd@linux.intel.com>
In-Reply-To: <44b1519b-f9e0-476a-ff47-8d21f004b3cd@linux.intel.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Mon, 20 Mar 2023 16:39:50 +0800
Message-ID: <CAEm4hYV8tz=1J_VwnMVH8+wsoWnJFtZFXawVPCuUgzVC1-8uZg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Add the module param to adjust MSI mode
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     helgaas@kernel.org, kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 18, 2023 at 5:31=E2=80=AFAM Patel, Nirmal
<nirmal.patel@linux.intel.com> wrote:
> configuring
>
Sorry for the typo.
> What about this?
> off: disable MSI remapping
>
That's OK~
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>
> Thanks
>
I'll resend the patch with your Reviewed-by if no one else has other commen=
ts.
Thanks for your review~
