Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802647847E7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 18:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjHVQpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjHVQpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 12:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B1184
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692722663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drSKQmIr7hHEh3n3jADc2gpNo2nyOeHA8jWVVkOgk/o=;
        b=Hss+rFhpoBP2kldt802xXHam1OMPmL6DxHqZS+M0YQVGm4TsZwcygBkoboGBqcPxURkYS5
        IzCM/bkcOwyn+8vRkGXVlpX0xAeAomr9/5Iq6+OZxJS71mRCurrAUEeS/LsW/HKW0Eiebj
        W80tokf7J37cRseX9oMkZWt2MQZPN/M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-c2C4OzcMPDqjFWp3jBZblg-1; Tue, 22 Aug 2023 12:44:21 -0400
X-MC-Unique: c2C4OzcMPDqjFWp3jBZblg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-26f51613d05so2744794a91.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 09:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722661; x=1693327461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drSKQmIr7hHEh3n3jADc2gpNo2nyOeHA8jWVVkOgk/o=;
        b=Sk0jOOKoRA7cHY+ZqPJMQPBq8BRyDN4nhzX4kZuqtuofin/fcOkZaBHyfKMhj0JjDL
         utNtXGdleHFzPrfl2ynvJ5cb3fc0+i6gD9WFfD+2LA79MoP8WnRCaC/pD4jKVx1W6v4q
         AcNBW1N8AmTw9/jsJiEVockacQRwqa5r8sbG8nHVQxNyvmifkWE84RXn2KpBAKbJWvVq
         AbyyILmpJ7UdQuKpiMAgJy740Yeuox7L5oraCMV0PME3JhOk7b6QihQGkYJ+IAAAlf7m
         Zqj0Z4hJAvzBiQjU3EoRLZEka/MEr5idVcnyzoHf9QmIcMN9fdW8qUpAujIapXSW72Ab
         0CaA==
X-Gm-Message-State: AOJu0Yz56ZSSvZxqmBweRymfjEtoCJ3w6mhhswg62F2fvpZeKQ6GhwDt
        eYy8qrAJyhW996EBv3c92INnX/ED3V+RbW8C7fDpcF4KwFQUDJ78B45d/zakWC4DT5xsNM1H5Sr
        TAFEvmDypr/HzPr7Yu9nKLSDWtDrHZ5Wrumw=
X-Received: by 2002:a17:90a:b017:b0:268:ee6:6bdf with SMTP id x23-20020a17090ab01700b002680ee66bdfmr7276865pjq.47.1692722660854;
        Tue, 22 Aug 2023 09:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF87zFT+7w/2xuyn819nEqi0XKnQ9k5kT7k+IdPntcNXLV6sv7bznE1y2rk8e5Xm+mArgWezgi7gwWrImFugh4=
X-Received: by 2002:a17:90a:b017:b0:268:ee6:6bdf with SMTP id
 x23-20020a17090ab01700b002680ee66bdfmr7276851pjq.47.1692722660596; Tue, 22
 Aug 2023 09:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com>
In-Reply-To: <20230821131223.GJ3465@black.fi.intel.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Tue, 22 Aug 2023 18:43:54 +0200
Message-ID: <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 21, 2023 at 3:13=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Thanks for the detailed description! There was follow up patch that made
> the timeout shorter for slow links, I wonder if you could try that first
> and see if that changes anything? It is this commit in the mainline:
>
> 7b3ba09febf4 PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait tim=
e for slow links
>

Hello Mika, thanks for a quick response. Please see my reply to Bjorn,
the resume is just 60+ seconds delayed, not completely failing, I was
wrong about that. I attached my logs there.

To respond to your question, I applied 7b3ba09febf4 on top of
fe15c26ee26e (which is the parent of e8b908146d44) and tested that.
Hopefully I understood the instructions correctly. That kernel resumes
just fine, with the expected speed (~5 seconds), no extra delay. (If
there's a speed-up, I can't really tell).

Thank you for looking into this.
Kamil P=C3=A1ral

