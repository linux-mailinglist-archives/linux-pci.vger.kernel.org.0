Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC9311DEF
	for <lists+linux-pci@lfdr.de>; Sat,  6 Feb 2021 15:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBFOvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Feb 2021 09:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhBFOvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Feb 2021 09:51:20 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3230C06174A
        for <linux-pci@vger.kernel.org>; Sat,  6 Feb 2021 06:50:40 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hs11so17694459ejc.1
        for <linux-pci@vger.kernel.org>; Sat, 06 Feb 2021 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=aYqpd6CW6b/jo7Ey51dOa7J0fsgGPNTjsspzF0gY+euw4SkvTYZnZy+QF68nkNGEfm
         v/Sr7KcDj6tN5AVO8+WZmYLcmwOcWkw1Irhbi+rt1ttf1/XkJAKlge1+0N1Tfozj1R2C
         gnBgNOqZPKYD7SdZc0RWU15M9jQ8d+fY+TnhLX93F1qUWvgjqJPpNa00FS6ryl/8EVFP
         ipNmZu1yPes5y4vyMDyWa20gO1gbQDnv0jsf6PbKk7pmSKVkBv8I0YMKx7//GwOtxyvz
         gaEGZ88d0TpLW+Rba3943QDhc4gXKNC7T54e+InV5OxIO5Rqtue7YlOAbsIShpGC+BSi
         MLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=qKLvNszk4RDX3UYAbXwZT7P7oyB4+UwUczYulhLSu5C41C+YdtQmDWb8TRYoLlwhZU
         V2F7nbHnaZ/BhDTOTCDVwYH9hKs+inxVmQHVo6pEbeBSeJEEQsU4OABulJXBwHslBFn+
         ArTJsrHWYQCjOsgJ4HBWVEDV/p7HHSodyRB2T7P452na+eRHHrcuHWgb4IGLIcNTmTeK
         KRxS4adr0PjmdLg9JuiXLKbadixF7P1ymcfNEgz1VJCP+wxJt1dGxxhMUkoqq4YbETQU
         wjqVZL/iKyWx6h39HnZTI/lF0ya96gHYI90+A+6RQWnnoP0mRAjL2sd6pADrU9wT1gHH
         5oCQ==
X-Gm-Message-State: AOAM531FyBwo6kB35SAR701qi5ASKX3HLCDik2gbwpK321ml4EdeIvGM
        ecsrJ1soOEsVheWXuSlpyGkT8DFX2IWKgNUKzUM=
X-Google-Smtp-Source: ABdhPJwB9NEX2+geloa/tBEEYHQh+3L8C2YS5FvOwFCueGSr2V5twXGUjnuMacFGaVMW6DcgdOo2y97G+4qy0vKUTpY=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr9406356ejb.138.1612623039628;
 Sat, 06 Feb 2021 06:50:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:50:39
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:50:39 +0100
Message-ID: <CAGSHw-BjF5GELpzuwwdiSpKw2dUJWRnSfAQ-U_bQUT9VyiqMjQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
