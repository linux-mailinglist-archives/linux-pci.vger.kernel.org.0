Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A957B0653
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjI0OOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjI0OOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 10:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8CB180
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695823998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwGMspXDuqQwgGzZQ7MuwnixR8r/6+yX41PkMftGYz4=;
        b=BO3SaCyfy34bSykKWo3cEtyT2oFyQ/jfjXrjymix7IZZbHKrBb1HGYm/cP8+7alQw7Oikf
        KacVb4/WShj7k4WqHFMJTX696f7NZlfnBT4n+EWo1LbXoV9cSpDYfa0wp4N3bGGSMDx7RM
        A+lThIzE252eEO1tekK5yNFJisea7/4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-7pWfAwniPTagt-Q2LWSNlA-1; Wed, 27 Sep 2023 10:13:17 -0400
X-MC-Unique: 7pWfAwniPTagt-Q2LWSNlA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27903b68503so705933a91.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 07:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823996; x=1696428796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwGMspXDuqQwgGzZQ7MuwnixR8r/6+yX41PkMftGYz4=;
        b=tuLCCGlaFpcYJpklkQLUlgR6Q0uETgrMDmWNSou3LDgQAOjSvUSZXXNZOBzOIoxtrA
         cqXZYQ1eaCluv6OsdTViGpLO+viuHV2c5r+htTH/0cyrVYYx/A6FHWu43AjZG8bVs5Jx
         zFLp82g2CUVw1VTyrQqNPZ5p1rjfwK9H0UjrGrpD5raS84zcyJUcXbwsEoL0giBJSKu+
         hq8PVmrfC3KtgvSgFzvU7YqwQ5Ts76I9o6ULUbM/1Ys6EWYU6QcMc9jl+NofoUFeGuW3
         cW5E/DRi4FXww91lBskAQISvGKcOFeld4MBJOaFERQn4QU+/jG3My4CLOydmwn4ghImt
         ZFjQ==
X-Gm-Message-State: AOJu0YzpXENP31N5qrgYtS5+VkyyVmDjKq6wHIqIyxdBISqJtKiZaKpf
        vJOgvUfJyA9tuEjqnIIqTtGO7+74NKZx5KIy5GqBEC23UVC0pcMMwLmV2RV8nfLTTEOXqWjgXr8
        sXFBtl9vVQNy/tr14M5Dv7zOfWFG3S/EpNqY=
X-Received: by 2002:a17:90a:e2d4:b0:269:c7d:aac5 with SMTP id fr20-20020a17090ae2d400b002690c7daac5mr1678422pjb.3.1695823996060;
        Wed, 27 Sep 2023 07:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxiMFukLiuzoGHKM4zkNgY+ZCPmKLqqpigDPJnXvN+8OlgRMYmM8AtfsgIlhi9BQNL7S1WZyvC4P++uPO/6pk=
X-Received: by 2002:a17:90a:e2d4:b0:269:c7d:aac5 with SMTP id
 fr20-20020a17090ae2d400b002690c7daac5mr1678404pjb.3.1695823995777; Wed, 27
 Sep 2023 07:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230925141930.GA21033@wunner.de> <20230926175530.GA418550@bhelgaas>
 <20230927051602.GX3208943@black.fi.intel.com> <CA+cBOTds9k1Q2haC_gTpsUvjP02dHOv9vSconFEAu-Fsxwf36A@mail.gmail.com>
 <20230927135346.GJ3208943@black.fi.intel.com>
In-Reply-To: <20230927135346.GJ3208943@black.fi.intel.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Wed, 27 Sep 2023 16:12:49 +0200
Message-ID: <CA+cBOTfCy-KOptir9yfkVz1=bfOTPQanqe9ofX-jphm7oeBEXg@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 3:53=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> If you apply the patch from here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=3Dp=
m&id=3D6786c2941fe1788035f99c98c932672138b3fbc5
>
> Does the problem go away with the disconnect case too (and so that you
> have "secure" enabled)?

Thanks, I'll test it, but I can't do it this week. I'll reply next week.

