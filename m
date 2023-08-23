Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D938878510C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 09:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjHWHBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjHWHBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 03:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C2DCDD
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692774068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCxuyTwpAkZCk37mZn33IyDjWDzXgnaUh3RjKTM15/c=;
        b=P0PVWIKijx/wfp/hS/bIlnEo6D2ypac6rY45T9AdmdYVUOwMdBV03kQhM1aVVmuhIRR4un
        qttt+DkY7G9ey5v7L5/KpVTfbFf8OVr+f8P+Ie1PRE5mfhouC8HY2AQAyZ0JUoovQajV8a
        X8gcEaqjk0OMiC4ztu+EskJIsjOU85U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Qa9SD_ShMfmnBH9LdAp0wA-1; Wed, 23 Aug 2023 03:01:07 -0400
X-MC-Unique: Qa9SD_ShMfmnBH9LdAp0wA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f3fce5b45so4415753a91.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 00:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692774066; x=1693378866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCxuyTwpAkZCk37mZn33IyDjWDzXgnaUh3RjKTM15/c=;
        b=Z8Uy1bJV9xeiGA3ixUBfBqH22aHobzK1vBX1uk1YWTsJDZpkics8bEzNiFKRVmdE6G
         kFcspyWR0Xi48lECg262gXnFQJklEqHwa3ic+gwPYWpMfkrHDecmHQr1uj1/I7q30dsA
         Ta7ysCWyRy8BvPwoU+w5K9kB6Hixz34KBj4PadqiOvEp8Dc+TmopXHhLedj1beS5Fy1C
         0WIALz9LqFvlOL9eihNYnwe8OZZaThHonGv67YKssdJPFUrb8NejzA+ww3pRUCwiWT9r
         f9wdsuxuUoL9ConKykN0ozjQsYMBbWnEEOFXal2mW5bYK93c+b/uo2aerjDN1yIBrsE3
         66XQ==
X-Gm-Message-State: AOJu0YzP1FK/+D7m0FOmQ5aclvC9M39NwqkkUeeRvuVw0Z9AIP5Euamn
        QO6hHPF/RJJ3dtFEwgHRZw9BXn73Yap13wjxk07DKvScwEGBEkijqwQfUkbkHkQW7uRIGZy8KVb
        tw0EVlNW93v+6to+qyvDf3wo4Ct+1ycTMRXo=
X-Received: by 2002:a17:90b:1882:b0:267:ffcf:e9e3 with SMTP id mn2-20020a17090b188200b00267ffcfe9e3mr11020166pjb.46.1692774066039;
        Wed, 23 Aug 2023 00:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwbDCu65zazbtvERo2dSRY8zAUK59fINDdDAUFIjyiz53LnwxLGt7vY+xzLr1JpWTI+nrQCWgl97TYj5JqCkw=
X-Received: by 2002:a17:90b:1882:b0:267:ffcf:e9e3 with SMTP id
 mn2-20020a17090b188200b00267ffcfe9e3mr11020148pjb.46.1692774065746; Wed, 23
 Aug 2023 00:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com> <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com>
In-Reply-To: <20230823050714.GP3465@black.fi.intel.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Wed, 23 Aug 2023 09:00:39 +0200
Message-ID: <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 7:07=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Okay if I understand correctly with commit 7b3ba09febf4 things works as
> before and you don't see any delays in resume?

If commit 7b3ba09febf4 is included but commit e8b908146d44 is
excluded, the resume works as usual. Once e8b908146d44 is included (it
doesn't matter whether 7b3ba09febf4 is included or not), the resume
gets delayed by ~60 seconds.

