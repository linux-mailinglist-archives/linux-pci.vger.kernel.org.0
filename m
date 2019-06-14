Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A3645332
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 05:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfFND6C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 23:58:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41065 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFND6B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 23:58:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so918642wrm.8;
        Thu, 13 Jun 2019 20:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uwDYUfNCDx2fc22MYxlEMUfeH43G6/A1w9YTtwp2O8o=;
        b=cNTJS08pTE9SEPqFUodQMBq/Hj7duJI8Zr4Ew0SOhr+J0VnJE7BDBAByAU2aUWo6RE
         cJRxBZ/Ou3cK+1gMzSkxXtENB0pu1e59Uc1vjsbiF/MfLX4yJoIvApS8VtUGaGbIr4SK
         SSZwcbudnheS4q9QhtjCqiyMEed5HmSTd4uTbTryQzBqwcAp3xqjoKfZpFel5hn+mXJM
         YUjkDPu0Usvx6IcEfpG0N4yBcq8JeOajaqlOj737GrDwQVD3nlTvgM++V85GmJVhkbgM
         CNJhz4BFmiLrTa6sxr3yyM4LC8f5t9wO3NqEVXXJ3DHvmj7EbbKdSvmsYobGd1Wgypml
         0I4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uwDYUfNCDx2fc22MYxlEMUfeH43G6/A1w9YTtwp2O8o=;
        b=T/pWPWRIj4wkwskvQu9ZK7iphwtOQUkCwd8VtqejO6ZxDRGNuKTP7l4FE5utCBUt8w
         /SIzjv6iTNp0qBqE6pGlxJ7PVzaazqbHazi/CHiIOd1Lt1Tj1g5mD5pRguxvB1NFFuKy
         rA88RGwi/2irez7rBUy1YhYupSuM0ob9rdoE7voolnnHyTYmZF8Ti4OseK1jM3Mse3G5
         EBi9UhpXrhFsNA46lyRzVYvsr+z4HbBrsOn+p6hnb//Phz2d6DC8LaaKfCMVPnJoVpOh
         IOwZ3Anmdz+LtlMnIUnrdAoy5n5lgOM8+dr0SYSmdqPBz/HI6z39CK3cf1hKYSnY8cJH
         21RQ==
X-Gm-Message-State: APjAAAWb5AUS9hLQLfZhDs3Gm8zehdQV1BUcYOf4whvnNnWZ7ffEWqYm
        lzcsidf1SNmrO2HSva42Alu754SEwYG70EcL31k=
X-Google-Smtp-Source: APXvYqzVVsuxOItdPfuVmbf8Pq7kj1cON92Rhjm8GlttyUt6YygwE7reL5byAOMboxnj7/kzmjHwk+RnoOHon8Ejuj8=
X-Received: by 2002:adf:b64b:: with SMTP id i11mr11657992wre.205.1560484679581;
 Thu, 13 Jun 2019 20:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <1558358244-35832-1-git-send-email-mowendugu@gmail.com> <20190604112905.1f16232c@x1.home>
In-Reply-To: <20190604112905.1f16232c@x1.home>
From:   =?UTF-8?B?54us5a2k6LSl?= <mowendugu@gmail.com>
Date:   Fri, 14 Jun 2019 11:57:48 +0800
Message-ID: <CAAPrRyRP5MPKH+o6J7H-jRtG8mLVD6-VoBmT8mFL_=Wv5ST1wQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI/IOV: Fix VF0 cached config space size for other VFs
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Quan Xu <quan.xu0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alex Williamson <alex.williamson@redhat.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:29=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Mon, 20 May 2019 21:17:24 +0800
> Hao Zheng <mowendugu@gmail.com> wrote:
>
> > Set the pcie_cap field before getting the config space size for
> > other VFs. Otherwise, the config space size of other VFs are error
> > set to 256, while the size of VF0 is 4096.
> >
> > Signed-off-by: Hao Zheng <mowendugu@gmail.com>
> > Signed-off-by: Quan Xu <quan.xu0@gmail.com>
> > ---
> >  drivers/pci/iov.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 3aa115e..239fad1 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -133,6 +133,7 @@ static void pci_read_vf_config_common(struct pci_de=
v *virtfn)
> >       pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
> >                            &physfn->sriov->subsystem_device);
> >
> > +     set_pcie_port_type(virtfn);
> >       physfn->sriov->cfg_size =3D pci_cfg_space_size(virtfn);
> >  }
> >
>
> This results in set_pci_port_type() being called multiple times on
> VF0.  Why not simply delay calling pci_read_vf_config_common() until
> after pci_setup_device()?  Here's the alternate approach:
>
> https://lore.kernel.org/linux-pci/155966918965.10361.16228304474160813310=
.stgit@gimli.home/

I get it. This is a better approach. Thank you for your advice!
>
> Thanks,
> Alex



--=20
Best Regards!
