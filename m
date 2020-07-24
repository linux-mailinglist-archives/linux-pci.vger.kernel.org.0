Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8A22C476
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 13:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGXLnb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 07:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXLna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 07:43:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63709C0619D3
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2020 04:43:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so9639459eja.9
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2020 04:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MRJYdBEWDkphEZG/UEdwwg3luf4wsGYhc8hRIEMMM04=;
        b=or6Uo2WlkGgO2Vs61tjrB0fI+DFwETamJwcYT8CEke4IqwDXc+j+d6lv3uz0cCMh93
         r+hIlEwalrpnFOkI9Zm18CeIDJvSy1AqzMaGNOTWBXdxUwrDxxR1Y5qLuEa9tU86BFGh
         xdCel97EytwpOu0mkJQ+AmwX4/LZNML/bNSTOeB/lZ8YIU7H41mCevU7AgYawv6dth70
         066I5kQhVFxSZRNIyGO5VAfLv/DMA52dN30yGM3b8B00ZgmDfCjf5UB2Mdvei65vRhnP
         e/UZYzJ+Dg8GxXe3Q8koxbBXgxqpOrUwG++dgfHdaORSPf+mXOlNZ8i5aYuiLbJvyGdv
         rjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=MRJYdBEWDkphEZG/UEdwwg3luf4wsGYhc8hRIEMMM04=;
        b=P0agTaWUAByBtq1qa7PjqH4xEmk301b1Gt4UeYyD1VqG81QwMfBdxPlzv9g9AMQE9w
         0W2LTtGmdsoxPwntaJVgHe5GOCNVjYSm6yImT+mYaZ5X4eJ07IVlddZJO+yF4MTPRMpM
         rSepzLOFPJyMrP2HpAxi6/UpyU9EAqfypGJf4l11drYlcWYzZNSEUzEXsz2gebRObKGk
         wVdQZZpAr8qyRjvJjbc4eohhdM7s2b9ICr1PVjKQF0U1JnGBiqUnOnQ9VbYCbQsMnhup
         NGjdhNQ16b/seVBcqqscwHha89Rqs3cN0QZ/5ut+KL3zlzFhG/80X0EyS7il3d+t4lUJ
         VxNQ==
X-Gm-Message-State: AOAM530UjSM2JXzml8eAZ1K0wC2f806fNM7W55hKVVD9K9FUP2mh6ViU
        H+R3B06+K+dvye22SZlvHzOcVyKpwWvkH/E9/RI=
X-Google-Smtp-Source: ABdhPJz5/rkLkNsg5S94AUBHtyYkXjEmD8Bh/2CfzpK5urRz4iq9+RKHbzg9qThC8OC/fvAjv5WlS5rn5ntMVkWq0eo=
X-Received: by 2002:a17:906:3a9b:: with SMTP id y27mr8676517ejd.38.1595591009128;
 Fri, 24 Jul 2020 04:43:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:114c:0:0:0:0:0 with HTTP; Fri, 24 Jul 2020 04:43:28
 -0700 (PDT)
Reply-To: jinghualiuyang@gmail.com
From:   Frau JINGHUA Liu Yang <dr.udaspellcaster100@gmail.com>
Date:   Fri, 24 Jul 2020 13:43:28 +0200
Message-ID: <CAH_k5AG0sxvm2QrhL9jBVWk7FHAe=bonL9s-vq=C2dBfE2CkyQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=20
Sch=C3=B6nen Tag,

       Ich bin Frau JINGHUA Liu Yang f=C3=BCr die CITIBANK OF KOREA hier in
der Republik KOREA. Ich habe einen Gesch=C3=A4ftsvorgang. Kann ich Ihnen
vertrauen, dass Sie diesen Betrag von $9.356.669 USD =C3=BCberweisen? Wenn
Sie bereit sind, mir zu helfen, melden Sie sich bei mir, damit ich Sie
dar=C3=BCber informieren kann, wie wir diese Transaktion am besten
perfektionieren k=C3=B6nnen, damit das Geld an Sie in Ihrem Land =C3=BCberw=
iesen
wird.

Sch=C3=B6ne Gr=C3=BC=C3=9Fe..
Frau JINGHUA Liu Yang
