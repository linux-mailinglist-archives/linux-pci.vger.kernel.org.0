Return-Path: <linux-pci+bounces-10793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146393C649
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4801F22884
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D219D062;
	Thu, 25 Jul 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKHfxdxQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AB19CCE6
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920906; cv=none; b=SIi/xGQvLZhAZmwDq95dvyCIAn9DORncJiQmi1Msz6+BPWdRw+en4abxs6RWTkqSqEAhA8JeP9eMy2w25B2O1Vr1KUmyIYaEmdZtijmpccRJRg2bg94GVVRWiP2SLUoJ41i1BthrOZQL0IPwAq6nJ6D/cHQrrF7mSvQWXkvUz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920906; c=relaxed/simple;
	bh=RkNVsX0GJWP39VhHnsRew4x+r/mYmpi8tLHm7VuNQnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOxuNSMT1/JKDlj+qes/hR+N2LQRfjrWScBRYYLQ4TISkBbt0PimOLtugUS6JpSGWOZRQeQ6uZ+NYD1N9Gomo/xWU08DFBsA9Tw+IN/SEVcTs7r9f+uay0k/4XhbQ4sE7kpnlYU78SXdtoL6tIguDrZBApnxCzpRwzTC9uYTIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKHfxdxQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721920903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8Tjgy4dHalmku2MigGV36hJgcomQ9zlrQHbeuGTVtQ=;
	b=MKHfxdxQDLeDjoRt155tJ66XTkJWcNhC3MIoXZHa6Sm14/R6uSUrvGloGWND7ShEkb5F2C
	Z9AlqSyerw5ZaURvkm9j9Vw8loYfdvgeEmtxp2bXh9mdF8ZLaLW7nwvIbAkS2U70OzZ8Is
	LITaf/5iRewgeCFu+AOf69M7gAGxDCk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-2-Ht3IS9PAKMc9Jj3iGJEA-1; Thu, 25 Jul 2024 11:21:42 -0400
X-MC-Unique: 2-Ht3IS9PAKMc9Jj3iGJEA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4265e546ca9so1851205e9.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 08:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721920901; x=1722525701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8Tjgy4dHalmku2MigGV36hJgcomQ9zlrQHbeuGTVtQ=;
        b=GSUA7otuT+AXzcpAffoWQenLDP/R54A8kBz+bMSDy9lDvExnJLdyB14UWxonoKwO3t
         dCsaaVFgnupUZsl//qXNZciPhu2sBhz2L/uU3uJvAU9qgGMKR+9ktBmFJdKi1uBW/wJo
         g/S+UjQnvN+fE3hCRgoOvfjeowhNNS90Jcjb7X4bJ21DVmuFPIW4ZKY5s6gk2K6/57EX
         d3ywOzjbbU3o4VDtV/80JwOOIWE/Hdx2mIeSVS64HjwpnlDGBhMp0P13lbo3qeMzBOTR
         pLLSANRX3n7DdwA5Hz0e19e3flK8NTRY9hLiABz2/N7XiKJGIZ2ef8OFXe5xitf0J2/G
         AYlw==
X-Forwarded-Encrypted: i=1; AJvYcCUH0xSgA3rw2bSXaeNJ/Q0h6X+/zI4Bz6n3jxnKh9rs7ph/AW1WA5eX5a4WZi6ZvTZBbHiOdL9+l5Fj10fuegOFyy/SJJtkJHMH
X-Gm-Message-State: AOJu0YwHrYNryl0V/favYq/PDNyrmfW5Le1DdzIv05J47RG3lQ2BZNb3
	NwjbRkd8Wb45/aZWiKU1WZ/0EOZyMeZ7eH+ekkfxL3Sn1U1QX+KXY8P5UaO1Ws2ejz0nk/fmQ5k
	1nXq5w1tFsgR/e3TWHqaJ12MtbP8KfL1hGNqdgkpqDYzDG3663pXlmMxjgg==
X-Received: by 2002:a05:600c:19c7:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-4280576b7famr12152535e9.5.1721920901108;
        Thu, 25 Jul 2024 08:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUoq9MyYvXOU4HItbU3COs+rrthKOGlBJJ1A0/BR1JqKct+++msddOJXUIccyRZvEURjAPIw==
X-Received: by 2002:a05:600c:19c7:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-4280576b7famr12152425e9.5.1721920900677;
        Thu, 25 Jul 2024 08:21:40 -0700 (PDT)
Received: from pstanner-thinkpadp1gen5.fritz.box (200116b82d135a0064271627c11682d8.dip.versatel-1u1.de. [2001:16b8:2d13:5a00:6427:1627:c116:82d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36416e2esm2558518f8f.0.2024.07.25.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:21:40 -0700 (PDT)
Message-ID: <9529b8012b1a1573316d65727f231f5cf54d0315.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Date: Thu, 25 Jul 2024 17:21:39 +0200
In-Reply-To: <ZqJgkLxJjJS7xpp1@infradead.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <ZqJgkLxJjJS7xpp1@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-25 at 07:26 -0700, Christoph Hellwig wrote:
> Can we please fix this to never silently redirect to a manager
> version

It is not the fix or the recent changes (which the fix is for) to PCI
devres that is doing that. pci_intx() has been "silently redirect[ing]
to a managed version" since 15 years.

The changes merged into v6.11 attempted to keep this behavior exactly
identical as a preparation for later cleanups. The fix here only
corrects the position of the redirection to where the "crazy devres
voodoo" had always been:

void pci_intx(struct pci_dev *pdev, int enable)
{
	u16 pci_command, new;

	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);

	if (enable)
		new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
	else
		new =3D pci_command | PCI_COMMAND_INTX_DISABLE;

	if (new !=3D pci_command) {
		struct pci_devres *dr;

		pci_write_config_word(pdev, PCI_COMMAND, new);

		/* voodoo_begin */
		dr =3D find_pci_dr(pdev);
		if (dr && !dr->restore_intx) {
			dr->restore_intx =3D 1;
			dr->orig_intx =3D !enable;
		}
		/* voodoo_end */
	}
}
EXPORT_SYMBOL_GPL(pci_intx);

> and add a proper pcim_intx instead=C2=A0

That has already been done. pcim_intx() sits in drivers/pci/devres.c

> and use that where people actually
> want to use the crazy devres voodoo instead?=C2=A0 Doing this silently
> underneath will always create problems.

That's precisely what all my work is all about. The hybrid nature of
pci_intx(), pci_set_mwi() and all pci*request*() functions needs to be
removed.

However, that will take us some while, because the APIs are partly
ossificated and every user that relies on implicit crazy devres voodoo
has to be identified and then ported to *explicit* half-crazy devres
voodoo.

More details here:
https://lore.kernel.org/all/20240613115032.29098-1-pstanner@redhat.com/

P.

>=20
>=20


