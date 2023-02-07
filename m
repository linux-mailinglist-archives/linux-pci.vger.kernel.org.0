Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D0268CD5B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 04:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBGDRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 22:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjBGDRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 22:17:41 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94A6EB4;
        Mon,  6 Feb 2023 19:17:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s8so7476849pgg.11;
        Mon, 06 Feb 2023 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEdx9HDblWu1Giy1hcfGtLMQdifTw+HkdbmqOyodOVw=;
        b=ZQguRZWuUDg7ejfZ/13IUqBONLkGw/N7iaWg0B8vANmtG84iFjPnY6fM1T5sxuvWr4
         BVXFn6dpf0dSLPAoIYvSchUqB8uw7ldaR5AZm6NwPimviECDkBFkBm6pQa2095BxMH92
         OwNggtDAhapuz3RfH2ox88YncBCOeggM6qJQBO0EK58MjVlFx+gHpgXQvOM5/e3qiOvx
         5hzyq46Q4AcvttjGTckqq9ZvzwOrSUI8nxEDPt4S7GdqHyPvcMjJj8v8dR98M6bCFQjh
         rVRusBUsoQJCJLQPhRneG4bZoWWGE50xquMq99QwVcRPcbqhAFpgf79Yz3cGuuxHb1bk
         G6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEdx9HDblWu1Giy1hcfGtLMQdifTw+HkdbmqOyodOVw=;
        b=YDzSoI6NccQxB2MGZxnXemr16HjSbmPoHbJak2Wgz8zpobJKN5jLyOxxa0H9/+as3a
         xnxQombb+2QNN05Mmw2y29k9OpE4L8fFtMeGvnXUlAtVbkmioJTjyooZfAGX21USoUTU
         pwhlBloEi27XLtkWonNPSFAc07QnQcnxyHP2ZsUA5CgSjDdp3v6avE0Bs7oRlhCfBDtY
         8OVl7yxns9PV5Zq24rPsCIdjaJHimCV+XXlQoeVAKP/ClzMl14LE0hZJciGTH4mXjLYQ
         NVqH+oP/dntf3yM2h7Da+Gp4EPZ+a+4KNpjeS1IFdtUTkn0x8pt2edBB09rMn3fKUYTA
         6+/w==
X-Gm-Message-State: AO0yUKWYAvRbndCNQKPaYKIPpZObzjICuVRgcaFDQayjUcZ7nTYuRLuJ
        gI001Po5ac5JWN+by0B3h7G87DRZidnF6DufcH0=
X-Google-Smtp-Source: AK7set/IgnWvC+1T7ik0Cn8q8NqR2wk3vROsEsFNmbgUQDJ+HPmjizDorws0xZCeIry6U0mHESWMMzbsaq+75SD8HP4=
X-Received: by 2002:a62:2506:0:b0:5a7:2295:cb03 with SMTP id
 l6-20020a622506000000b005a72295cb03mr330917pfl.18.1675739838359; Mon, 06 Feb
 2023 19:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev> <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev> <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev> <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
 <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
 <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com> <Y+FG2EUpmsmCZqwh@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y+FG2EUpmsmCZqwh@kbusch-mbp.dhcp.thefacebook.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Tue, 7 Feb 2023 11:18:14 +0800
Message-ID: <CAEm4hYWjaVCDFtCCyHrq5vOie4wV5LFn-UVZ5qQbpASxVGy1TA@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
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

Keith Busch <kbusch@kernel.org> =E4=BA=8E2023=E5=B9=B42=E6=9C=887=E6=97=A5=
=E5=91=A8=E4=BA=8C 02:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Feb 06, 2023 at 11:11:36AM -0700, Patel, Nirmal wrote:
> > I like the idea of module parameter to allow switching between the mode=
s
> > but keep MSI remapping enabled (non-bypass) by default.
>
> Isn't there a more programatic way to go about selecting the best option =
at
> runtime?
Do you mean that the operating mode is automatically selected by
detecting the number of devices and CPUs instead of being set
manually?
>I suspect bypass is the better choice if "num_active_cpus() > pci_msix_vec=
_count(vmd->dev)".
For this situation, My speculation is that the PCIE nodes are
over-mounted and not just because of the CPU to Drive ratio.
We considered designing online nodes, because we were concerned that
the IO of different chunk sizes would adapt to different MSI-X modes.
I privately think that it may be logically complicated if programmatic
judgments are made.
