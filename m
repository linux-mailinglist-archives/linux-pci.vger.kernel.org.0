Return-Path: <linux-pci+bounces-38588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F193EBED365
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994635852CD
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC122127A;
	Sat, 18 Oct 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Te1YqZqN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941931DE8B5;
	Sat, 18 Oct 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803560; cv=none; b=LTH3VFC88xARwX301bugTXs+4CJdTEcUrlGMISYO52Lu2tLm79BAmEBCk4dH1sRE+Qj2Rp8HgUk4Ad4vA+jDxiWstBA74ObWw7HqiEzfSoQT1TdqEzhVoSknyGKNh1FDAdyVSfeP8T7POAWnT9Yabdb3squLX8s/pGzVdocID9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803560; c=relaxed/simple;
	bh=DVpegUpSnMQ/56u+X0CUxjEqDvExY1tOdeAx4+i8s34=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=h3CptZSN4tmb73bRUtjUFQ53CiJM/LQ1/JWIIU6vj+Q1xItHjN1wSlonYEh6WX8xyVnDafhh5Acdyef9bdnWuat8J0Y3xZTOjJ1rPerUHVOdchzvrZOUjiJnJc/tgnE/nQTFg8wcZxS6UrSlZvGvIj4zJhuJxT6zo79jBv33jSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Te1YqZqN; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760803537; x=1761408337; i=markus.elfring@web.de;
	bh=6nmlFLrqDO7WFS86Ux5VB7V/oLmiDIqjhANGFq7HoyA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Te1YqZqNx1Z3Vqfq67ldzTZ4FI9PKoKT9APFw5DrElS2ylIbUcTjq4Rg30iKA/6W
	 KxtVqbLEwxgogM3VlkejlbVn29dcNMms4H4Wx/L5/6hpm3Gqq9y8fOQDViHXmKBqf
	 87ztjISe9AqiJ0CxI1JWCukgrUXuCuAAd5sPr4giObQJ8mMinGgobMMcWdxQfJ2C6
	 EneI4nGbSBEahJp7wrGCRVVZwRIkNcMb0H2Vhsp3drpLF6yokCJ5bEZGHJYjBk74A
	 2tD/xecudirhmJQZJv1lGG5+dveb33CfGfTSrvvJ63w/T/kE94V5t1A1V1vHJp9ub
	 YlJf3pZbncJfvqlD9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1v4uN02IzL-009wEu; Sat, 18
 Oct 2025 18:05:37 +0200
Message-ID: <03a8fd58-cce5-4b84-adef-6cec235c582b@web.de>
Date: Sat, 18 Oct 2025 18:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 linux-pci@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <7b153f5f-fbec-4434-8d07-155b0f1161b3@wanadoo.fr>
Subject: Re: [PATCH] PCI/pwrctrl: Propagate dev_err_probe return value
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7b153f5f-fbec-4434-8d07-155b0f1161b3@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UmtNCvz390BhV9nvpDEDGMKaO9OcvirnaDHtbycXfPLLtIbRM3D
 aK0uJGPaYhXE2BDp51zUD+dlz49rFHiP8O+RakkX7FGmjj2No3Yz8r65LVB5pXKVLbzOJnE
 CxD+cLL4mty//ZydRXyK9Mzqb7plWiPHdUpvS1BiC2d4DFiSoziUrR/um3cNj3Dv0WOvbOq
 m2V1vKY/1R26w+an7n2fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/rscgKHJgSI=;Xnxt5lSDkZ3vZ391UcLeVUer6Kv
 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
 Jyj5rdEf7RIhAQxNDhr/s07LDg=

> >   	slot->num_supplies =3D ret;
> >   	ret =3D regulator_bulk_enable(slot->num_supplies, slot->supplies);
> >   	if (ret < 0) {
> > -		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> > +		ret =3D dev_err_probe(dev, ret, "Failed to enable slot regulators\n=
");
> >   		regulator_bulk_free(slot->num_supplies, slot->supplies);
> >   		return ret;
>=20
> Doing:
>     		regulator_bulk_free(slot->num_supplies, slot->supplies);
>     		return dev_err_probe(dev, ret, "Failed to enable slot regulators\n=
");
>=20
> Would be more consistent.

How does this view fit to the commit ab81f2f79c683c94bac622aafafbe8232e547=
159
("PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure")
from 2025-08-13?

Regards,
Markus

