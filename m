Return-Path: <linux-pci+bounces-32735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0783B0DC42
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4971715F4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BC82EA72B;
	Tue, 22 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTF8JVtM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD1288C01;
	Tue, 22 Jul 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192608; cv=none; b=lj6VovM8Pc1ZLCSTZV6ysKP2Pb6KBByC82E4nh+H6Fmf01GL3QYLH9N83TxIUsGnC2cP0mFRGOJYIEXjXg9ZyVPlZF8ZL3Aknlh/uVXvsinBVXHMTjLOGUp8zmS/O4Swt2QxYfn4iWjc+0gcJFKAmF5qEFRopFXZ1FIVUhrtb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192608; c=relaxed/simple;
	bh=kYYGasiChIGrOp2WfdbyJu8FXaB5dOTDpOSPPXTmqKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isdz7THZ7xXLLi5fH+IKr/BsB8TU+4qy5Rrgjns4j8J6LbeQVLTJDKspN7Atn8H8yjAVm/W9SNK5uSh7NTb8WC3MvNkp68MDZFvdWuH08eAneaneJAVX1O60SjN2DEv0/nRtKa4tqcDZG3ooQN6jq4jtYV3coFHFZxyVAd5izcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTF8JVtM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45610582d07so43416425e9.0;
        Tue, 22 Jul 2025 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753192604; x=1753797404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=juq2LsaB2ZlgXJfLDxNWAXy+l+g+CamQA/55GYnNXGQ=;
        b=MTF8JVtMdMfifC7WMEG5jFRRgshh2dk4WsmDSnnHnMOhK2U9M04ZL/0X+r46Gttd+t
         TUoJdwShZPbr5wvm3m6dZKML+9vxPvGQ+aBwqapqoJYjwVyTDYhNosuJTvtpN7iE5jfp
         a7tO455Ql2nkDUBvl0IFdHw7021yPU8cZJnNNyTwLCLxu/Hppwwcmwk1qxHaUjg6oncI
         kkQdrZ/dQSPDjhpoRt/if2zcK1B6/7in26kSntWsfBbeXmq6qZEVU+6VhctuW0q5wDrV
         Hapk88JXd3tQROZARhaZ+De4/nUTTC8IiqQJi4/h6qVq775aYoas2njGBSGvajgrHBdX
         sDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192604; x=1753797404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juq2LsaB2ZlgXJfLDxNWAXy+l+g+CamQA/55GYnNXGQ=;
        b=H2/enbslyVmfAbdjqjb9fGsJqzOtVBVE7PF1XQXGL98F1d/0prT8yo5PJxYU+Ej4Qb
         EfkltjI9wqw7NbAkAbMcODVg0HejLrKO2r8D9iEJn134q02GHlSNEV/rIVGTM1CN4Pld
         rzFh9d0zzf7L29hj5N1ioMhvJ/WVoAgi/20XcD9TJhRWiKLSqWe0QhvbAsYfdzuw2Fw0
         TgvFON+qVIw2N5K4AQ/3x6jWmouUjF9qAgmivNCDJZ0Z2euLOecOSTmzrs90ZOOmoNlt
         pDm9FPDXIdp20Bw+iots5IgUXl+IQFzLKI2mH9NW4GQSxVMTnMmSKizdg9fz9scJZ3/0
         K/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUApe6s2fksXuUZlg1hX4fxXAZS+NS1F3WvfAiMIWt9yBm0V44FFul9rzbPfl83zpQKLELv57O9XWfcyssa@vger.kernel.org, AJvYcCUU59zv/vSrCcdQzolNQ9eAlhcIg7p/mh5kRfpDtbZb4p1gnUSNUNFZAM+Y2SHvhBWqn+FtRCwZSLbc@vger.kernel.org, AJvYcCUykiTcRYOrPN0b/mSfOgDMvSt33jgUp/RMyle1+cBe9yOy2hUerMsSASwkR0peowtK8y8Ia93Et884@vger.kernel.org, AJvYcCVS1OaIfZAsZNo82qthNxiU2es0KZ/YkGNjFvo87ZE85q9k0k/MX3voYYT2DcD5x1KWQekaH8Zwzaut4w==@vger.kernel.org, AJvYcCWrFODVljnhkpRLphUK24v1pQi3+dKxn9BaNFQuFBLICe3ROzwTMc7okbrB4NDdM9u9iRQi4Su2o/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMDjysXRIJR9IHggEhZvP4qd3gLRMjlL863QagtEZmuWwl+A6
	ajjenTAIuJbmjKEH2oIVnsl4w0hLHgwUjA7xrygVz6hEyzHm4mcZcpEBjlzoHQ==
X-Gm-Gg: ASbGncuGRNOXeMvc+TkpmaQk/x0ZPr/3OOJ/Z2h/wvpv5SZ1+9i8Ezq80EMHE/Qu40Y
	zw5WEGu1mf3/+gbnZPQ1Q0hvddH1HnL/XljvRxRYxF594kOrHTGWbToTlczFAACDCEPiJwbBQbX
	UUj7G0ErpLkeWvLRpGZRp3fhKfvsSgXeGa22sBSBqEmL4wTrw+EcQxpp8fWIDbUx9wlSQ+ICyOW
	nvVO/rSZFwNURADwpH5IQHh2ZUtbsaECsiPsGgOmE8VsMR1y5yP+pwRoOGSfE4VZHaiDq/rkTyj
	hS/wVi802+PWnllhG2zWyV6LgEWvMeZP4io1IyeWyMsM/rGBF6Ug2s9E3Imckx4l2t2037a4IAg
	zJEuNfnIEIz0oZ8qLIPFvm66FnvSRksPuieik5z+cEk38cys3dI/yRzkU8a/iEw2Q53rz4pBFAA
	3NiVH5eufQ
X-Google-Smtp-Source: AGHT+IEXfV5AQDvaaCQOegEyKdsH0umt5I9YjBYWNMUwcatDOEmZLLM8MRQ3Lk0kGHyWW+MsfUSbDg==
X-Received: by 2002:a05:600c:c16d:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-456352d0b70mr190106725e9.5.1753192603600;
        Tue, 22 Jul 2025 06:56:43 -0700 (PDT)
Received: from orome (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2d4fsm197624025e9.4.2025.07.22.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:56:42 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:56:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
Message-ID: <l54i36uk33je744w4f47tehdopk5dsjotvozfv5b2hehmxrwpq@eins7awyq4dy>
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
 <2025071716-phoney-object-1648@gregkh>
 <rzbzah5iigz25jtxyqadnitkzkazxsaxntajhlfrfdslyioevk@pylcjkfh5n42>
 <2025071919-patience-cattishly-cf7c@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sm7baow4ljogvsjb"
Content-Disposition: inline
In-Reply-To: <2025071919-patience-cattishly-cf7c@gregkh>


--sm7baow4ljogvsjb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
MIME-Version: 1.0

On Sat, Jul 19, 2025 at 08:52:41AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 18, 2025 at 03:49:37PM +0200, Thierry Reding wrote:
> > On Thu, Jul 17, 2025 at 02:11:41PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jul 17, 2025 at 12:32:34PM +0200, Thierry Reding wrote:
[...]
> > 	struct syscore;
> >=20
> > 	struct syscore_ops {
> > 		int (*suspend)(struct syscore *syscore);
> > 		void (*resume)(struct syscore *syscore);
> > 		void (*shutdown)(struct syscore *syscore);
> > 	};
> >=20
> > 	struct syscore {
> > 		const struct syscore_ops *ops;
> > 		struct list_head node;
> > 	};
> >=20
> > Is that what you had in mind?
>=20
> I missed the list_head, so yes, this would be better, but don't pass
> back the syscore structure, how about just a void * instead, making the
> whole container_of() stuff go away?

Yeah, that's a possibility. I personally don't like passing the void *
around because it's easier to make mistakes that way. I also find it
unintuitive because it doesn't immediately show you what the functions
expect.

My understanding is that the container_of() should get optimized away
most of the time, so there aren't any obvious downsides that I can see.

But I don't feel very strongly, so if you have a strong preference for
void pointers, I can do that.

Thierry

--sm7baow4ljogvsjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmh/mJUACgkQ3SOs138+
s6FyzhAAq8z/gI18SVH4qmKTQkcFaPuXBegHTP2dgId1CA1dad3cmBj4tcAz1+Ng
liio3geyWrxKqZSJTrQOYYYloM4s9UhkY3AvXvDB+L4/DZC/HBgAGnL5dMKte/WQ
sNUniNOWw1gW2tluO+vi9saSGE4Test34XaIWpBaItJYO9uhuiAC57jJw9Uutl0h
wkjvwyxaOXSleKiCSwlnSBx31PCz7k5nhb8pIeptnxbxw+Q7+IsDzK/cH2PrV979
7AzVNifmqUfpO9Xy0FsSrYU0SrUCM7I8WU6elGSeuswDL7+Mlsh9kn/KfVyL86ed
0jP2iQRyzteg2ATh6dQJLM7KEPK8DnGZqaLDLJlzn3af7Mv5MvRGO1cx7dVGhcTA
ADto5YN6dKXC63ijHppnQ2xjZ725T1zuVpj1z5OTlXpKtlGvYiIejh+B5tjFMMrr
zTNbjIBbykgIZXvIvn52ttFRDrLgpnh2mQPzI8VWp9Bv0DaBH6Q1jfxUlWXQiSaQ
bWrFys6N7IBy5+o83FiAGZvQ//IFZhyF8T/6HD+6OuoX26vTOa5vwrPgs5qru2/s
T5iJf9UOqnHAuzssCGk2OZcqcVn17seSpXcJScckVPt/HhegIgcgxoVTCOBQ0K7J
xUhlsns/ZnbEGVKtLr2T/t7UTeCDZIkqo0pEloVCu9UGfeAI16c=
=Cczj
-----END PGP SIGNATURE-----

--sm7baow4ljogvsjb--

