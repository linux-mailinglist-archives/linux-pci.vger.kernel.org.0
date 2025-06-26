Return-Path: <linux-pci+bounces-30842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E0AEA8AF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07B316479F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9329925D52D;
	Thu, 26 Jun 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFrgfrL6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30325CC61;
	Thu, 26 Jun 2025 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972892; cv=none; b=WzvCBk1FPcsmYCYtL1v6T4Qup8mQuKoRfVcX27tzkGzvc0p72UH66c/ulU6FaJZzF618rAos2zgBAVS1fcGgEWIF3nq3AinlcdGz0S1TsgZhQNiqpYagaGShibWeJq4dWt+TBDCkmV3d/PbrPLfEa0boTTwqylyXpaoQ5BImWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972892; c=relaxed/simple;
	bh=dOG0HrfS6DLkGrpCJWNTcYMGI5WZCspSAJp1y6wzDXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAeqbOsfGkR+GYcMURu8rFUQkcZf0RsXNIRcFfUt4ggUk1+fMcuCvv7QoviOyEjCz9Bd4m3DcLdZXvitjVioSIo0Q05BdxOrhwQaZVe26rgHhWuCpFxrkVvCQVGONL1B/vd3KPwbUIAA8zPMf3N/VfmRgUjRPrGo2MdIO+wjCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFrgfrL6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a7f61ea32aso19379371cf.3;
        Thu, 26 Jun 2025 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750972890; x=1751577690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySd8m1U2l00Ktu9oTVtaSrbIW1X40w/4HuGETmgFpJA=;
        b=hFrgfrL6Qd4MA1oN5wnZcRM5E2Bi0NcO+zNzS/R+cfnn3ts9lnmlUStPC+LBPJWlhT
         BNQWZaeXj5ETQduN5uqp8quq7vaiQx7nFkZVBEkSN8vwzqTIHh+JTpJ3WtjH+zmRLuzT
         thY1TUoVRi7nz0sk60FTzQdMAyPqN5tdOcoIUFoxHUh6kyFW3x6I12L/I1w58C6FIkMc
         DvC/fmJLyEzACk19Vdb3prknJUJj4Yau7vE3D8KDZ4qDzd3oNrjeoTeFVi3bYjgEVBEA
         Ss0K7JQcznY4Gs0lxmBHtUiR0HfjOzsM4+iZ7RAEsv+74BzO0yTVbyLWp/zEueehSBFs
         vQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750972890; x=1751577690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySd8m1U2l00Ktu9oTVtaSrbIW1X40w/4HuGETmgFpJA=;
        b=fgNvrC6dJWzQkB5rb4NfiwnLwqqu4BpX+FkNepx9WQnkxZa6AR1BJiixK02wZFQaav
         GuPulnvbDjqv52MSVGNKCNx4d3YgcZMdtJpEyYgUinqDZhO6nJDC9M0KvWRU2PyCSr/x
         9YUalBOEqoa4cqyx5IFWMZO27fLQEbJZDw0piJc3OyRqkxxnefBvcqX09SH8J/2Km5Qy
         F/7w98PQvnvWNDeTRwr9gpG0BBXGSEbW4Dw1hQ+s5n+CpC5aLtdfrLMAIFS/v5laIiye
         3k/YlDn/EMsbjgHVktlHOi5sExCNdfnfGts+zcKkvCHf47gMgW2rECK2uM8a6tX25WZn
         DqhA==
X-Forwarded-Encrypted: i=1; AJvYcCV2gOXko2Ce96uaqbx48oHPfd8BtH3wqBQ3K1EnlXCHrpE6Or4VCxwQ25BKLUcXblzT88mBOyDtGuqw@vger.kernel.org, AJvYcCVAFY4qL4ICJp7z1IsxfkvZUfFnSyM1Vdi3LUTQcndOW6eCkrRa4+KrT+S7+8qa83mz7lVZmfbP9mICN7U=@vger.kernel.org, AJvYcCXh77DW+CtBn282nB/065Oiq35ry7oUU4X2Qg7z8rVB5VrgypJ8HM9gChrww9Nf8jAnhskeVH4Bqt9DqHOi0Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIQwKnkIIJD1+pDYmRk3wHzQLtvQkMeuSPaYpOPLYw4kpRIJh
	MhKuzCviIbM7PWx8c/FhFVd9AhHOPHAq/UQc84pH6xBykxl4Q/Jksb3x
X-Gm-Gg: ASbGnctjg2y3bwkoBizpwHFthfnQTFQStvcPWSYBpddpPKozsfSMwv0iD8Fs0/PCZHE
	n0nJZAE7gy780ghi5qV5J3cd4ChwXQyi2gEJrexAqgRfR/pa5cleGAi8oiNaQB+kY2HErgSyRVM
	S+vR6p5+wAhXz08kLFEV7YWaXdpJCPsnbCJ4jtnJ4c3IW/lHff2tiUkydD19WXQzq5EM+Gq0FJN
	cVktV7IsiX7m2hKAD9IM7N3TrDzn00XdQz2N3Z9FTdqxazsCzpMyrgTqPfnzi1HiKxw2rr7FZFm
	wSZjQQCVbJDqBM6NEMNL48uJW/6Z75hGzxrvmWcUO5GN9cIkR5ANzn9XnflvAL+XVdu7152egMs
	6EnOO92TYB7AHpgfG8jUbijr3dILQjiqezfw72aGiv0z4vXxOng7r
X-Google-Smtp-Source: AGHT+IGkKKTGlCgJRpYlxgg3mHb0Yh1EhRUTKyOzTCqZHwO3lsojOz6XIk5JJgyYpQcND7S+KKvJqA==
X-Received: by 2002:a05:6214:27e5:b0:6fb:35fa:7802 with SMTP id 6a1803df08f44-700029189d5mr22921116d6.36.1750972889739;
        Thu, 26 Jun 2025 14:21:29 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317cc43sm46743485a.46.2025.06.26.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:21:29 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id CCD3CF40068;
	Thu, 26 Jun 2025 17:21:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Jun 2025 17:21:28 -0400
X-ME-Sender: <xms:2LldaPFarsFKCaMS8_xMIQo6eK8fYgxmTeeYbP0T4fYRLz00K_Kxmw>
    <xme:2LldaMVaEzk8wbuItzAf_RA1XZWbm0Uzj2bOsWyn9s2xPJjq6w62Gbth_4AwFHlLi
    V4pKamJa8AEK9BUBQ>
X-ME-Received: <xmr:2LldaBL8xivlY3Q7OSKLZaNEwJcD6OewSD_HyF3_ka8q9OfSJZqSBJ0d7LRJWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhroh
    htohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2LldaNHrrKsVhgJpQQ-W6UjlzP-aLcfcdYnz1ySavB-XmCPC9hCGsw>
    <xmx:2LldaFXybVPS0XG-by_4D7SmYKA-UHGBWFQevqinHSDjH91m6qwTfQ>
    <xmx:2LldaIMoy-qD8vr-ejuzpwKfhT-tx83rlD0EhSDVYm8f50RLcQPL6Q>
    <xmx:2LldaE2DR-RAwfmYA-HLR2YwTOHp_2i78lYjlkNxnmZ0fdumCZ0CXQ>
    <xmx:2LldaKXiFkx-VB3sxkvNm0ZzZ3eOL9OgMbImGrdgabN9NH6ATwPVz9s3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 17:21:28 -0400 (EDT)
Date: Thu, 26 Jun 2025 14:21:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
Message-ID: <aF2514i-7To0NDEK@tardis.local>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org>
 <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae>
 <aF24vbtHgP-kYuBg@tardis.local>
 <411adfbb-1110-434f-a22d-d60914be6968@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411adfbb-1110-434f-a22d-d60914be6968@kernel.org>

On Thu, Jun 26, 2025 at 11:20:21PM +0200, Danilo Krummrich wrote:
[...]
> > > +pub trait Release<Ptr: ForeignOwnable> {
> > 
> > My bad, is it possible to do
> > 
> > 	pub trait Release<Ptr: ForeignOwnable<Target=Self>> {
> > 
> > ? that's better IMO.
> 
> Sure, that works.

Thanks! With that feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

