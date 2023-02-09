Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA93690837
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 13:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBIMJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 07:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBIMJX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 07:09:23 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163245A928;
        Thu,  9 Feb 2023 04:04:06 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r18so1387082pgr.12;
        Thu, 09 Feb 2023 04:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iL2H66c8egeJxcAcNd53DVufU1j4gsJh0p9vWPKars=;
        b=HYSrOHlOGHkCBBXo/FhVUHf4PNfH2Exl6Z6W8siW88APvdsy0cxj4dygVgp4Zyb6Dq
         O1xnt9GpA8ATgCFBeNTRTw5k1ZYRZONlBo0nHzUB5vrPjDDa0ZSFugYFs6jcYZIdVSZs
         P8uoxbRDQtjBraAyzqiz/b2ZS9T59i5c5oKxSGTCMgEt+ogkvVRC9XPqgCU1W/hsgsYZ
         lW76hmgEMdXVdpqw6Dd9Ti8wNiVgS/rEoPXwYD9nhvtayiUBNHW16vf533LJlbjZTdSk
         6joGlO8A3eFDuPCwM1BXmd0aex77OIDHxjUjD3kGmXfhw6Vcxar/FTtGf3MBnwPNcDMR
         BecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iL2H66c8egeJxcAcNd53DVufU1j4gsJh0p9vWPKars=;
        b=HAAy5t6frU176IYf6QUZubH+6VzQQJi51MfegxLfm6UdtqIOKVMyqE8UaIN7WhhoPu
         tHkhQ9k29hAAFIvkNHVS+DoeYzkO53nAkSeBcwG763jVkqDZPeXYRV/GT8+NeObJS49u
         y1sryTG+Ta6oPmGCTVQwgbp6noHHXW0cEeThOpN0KwKJgjtJGfLCWuRigBKobgxpeYML
         gyG18M/ChBDVyGChRNj3SAOLiBdMxVFyMpNp8MudlTbO3VpGOVSHyW0vCB/f5MmYP1rP
         iImDbMBs5qgNOR2KUqWky8lreQMcwWdvFWJF3u8OEopOFshUZRo5TUXI69u9HChZbmtW
         6ZHQ==
X-Gm-Message-State: AO0yUKVAvrtrVGSHIUuh4hWGweG3s/spoS/C4rpI8LUXESypU9s1nsMP
        n6uQAxiSvhjggyCE69Eat4aY/rzezeEKkc8YKV8=
X-Google-Smtp-Source: AK7set+5BFRT8raXxfWMimV2WpjqnoEHyVeYyY5HAmLqQ0HPH3rmaK6Yk3SELenr4S268UyMHdMXS0a6QNoea/S9LmA=
X-Received: by 2002:aa7:95ae:0:b0:592:6238:a2a with SMTP id
 a14-20020aa795ae000000b0059262380a2amr2455825pfk.39.1675944245529; Thu, 09
 Feb 2023 04:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev> <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev> <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev> <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
 <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
 <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com> <Y+FG2EUpmsmCZqwh@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYWjaVCDFtCCyHrq5vOie4wV5LFn-UVZ5qQbpASxVGy1TA@mail.gmail.com> <c830a68e-014b-ddec-4bab-5db337fc378f@linux.intel.com>
In-Reply-To: <c830a68e-014b-ddec-4bab-5db337fc378f@linux.intel.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Thu, 9 Feb 2023 20:05:02 +0800
Message-ID: <CAEm4hYU46nsN4jiRa0aoq2XTamgFj+OOWy=A+wXFeZFTey_8SA@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Keith Busch <kbusch@kernel.org>,
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

Patel, Nirmal <nirmal.patel@linux.intel.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=
=888=E6=97=A5=E5=91=A8=E4=B8=89 04:32=E5=86=99=E9=81=93=EF=BC=9A
>
> Also newer CPUs have more MSIx (128) which means we can still have
> better performance without bypass. It would be better if user have
> can chose module parameter based on their requirements. Thanks.
>
All right~I will reset the patch V2 with the online node version later.

Thanks
