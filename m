Return-Path: <linux-pci+bounces-24361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8DA6BD47
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33AB7A4C61
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2521D5CF2;
	Fri, 21 Mar 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NozLB0Kf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4A150980;
	Fri, 21 Mar 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568062; cv=none; b=PogSuwK1dePArjvPujuoadSO+XzR7j/owgxFKpjZ2NcP/3PFya0H+D1/R4kbOPJ1e+0/SLP2PGS2oQ+wocdMEZJ5bFERjzXk1JeXWs7TMCkOC4M1opMLdbczX4GpGuOXgyVQeMx4BM/S3bciW3IhBnGVay2Xz6LJbFs+7AW6K9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568062; c=relaxed/simple;
	bh=Z90p+xaK+EFoEhStSRUoWkQBIthseEVLwQPurEI6st0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+0COsXlo1GfDl+KFlile6XNVn72GVYo4TCKhcCvR60AOA1lbiSo9vXF8TPtY5V9bbMbq2qKDTkzneMU9r4I6ztfEYWOdSPkDuL+9xsjv95CeTAMIrxyPcC/7G4ozKE5RNwHp4Ef4iarvx7MCo7GmvfATULDdPfFqBAE4VszHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NozLB0Kf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46c8474d8f6so18806911cf.3;
        Fri, 21 Mar 2025 07:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742568060; x=1743172860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3mohH8SHkTJY14n+eN1OWy5xiwG9NkgqimAihyHiYw=;
        b=NozLB0Kf61BisQjfye/4Ihh64SzEiWN/OubPH0EayHWmmqQ89Ewcd5CutsWEe9DNhC
         IWkM7QYWWdBGyguxe1tfZDENO9cleKCKONbm5M94SxLn6kM2np8pC4f5tWNRkw0ZGD13
         FLKYjzFIU2A9vXjTl7NE4q2UsNtT9fTowVLkpT8NUJTmL0Z1xnOSjoHf7OVvcSXB0psT
         7nrb1P2iUiEdL00fYbyy/Cit6UJoIBGndYy95A3zt3jUbR6fh4mko0IbMIAQqOq8jJQK
         DOMXW8rNy7EtxNry+3UtzYNyeMlyjX0iNt5aWy/hYmZRvsdfBO2PstME3JZrjrcln21U
         idJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568060; x=1743172860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3mohH8SHkTJY14n+eN1OWy5xiwG9NkgqimAihyHiYw=;
        b=iPf2I75fsDrQETJdSJUaLV2qiTjnNobg6dseZWWIrbmeW7Pavcqfd4x7uPA0Kx4lZX
         pS9U0hDpg6jmjG4EjjPRKxIAVRpzA3hefIfWLqj8q0pJ4YlJbvgK1bNdtv3s23osWiha
         oZ3eUrDIXhWe5fssANL5WjZDfiUG7UsyzmtjumL9duWI7bpYSK0FwIiP67XnLM9KU93n
         LAG62/iDyBaRFoVKO9f0JPzlgemTCu8TganZOLMFvhIATjTOf9oIxIr9xUNsL+Ff9qHh
         Bd50eo7IqqW65AAhn2Uzz/9+OU1+b24Ufff3ErXTKR0Jpjfb1QnOiwEWXktEkxMNkmfU
         3WnA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4ZC3CTgKBq/9dg7lzyh0/EWeiOrGN5En8BmCKAK2aPSMTkptHQhXCYghRXgj5c6wANvyaZwHTHiQETULP7I=@vger.kernel.org, AJvYcCVpTaLKI1752SH+XRZMQsGAjsqdavt5ROI14zc5K2ffpLShipuksMGz3J/kIx45RdO5d01Z6ljNj6nD@vger.kernel.org, AJvYcCXPIAbZi13zRtJbc/MJU/ZwTC2w3ohwHX8VLi6UloPbjssIqB2S2qcO/VKZ7vdkU7oGxFm8lzJCfx7WKbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWRMUuAARLzhlXGnnIvW4WEpyD4OlqZvihx6DV6+U614m3fuMd
	0QVUUqS6ACXt4JyLNMqMKt7igNiqpwtbwfa/lhm+5/2idu5qXdLd
X-Gm-Gg: ASbGncvuat4gyrP411rWRlJwv21f41VnIyI0lasrVIYAp9DwSdo01Ka23sWSQ7IgNv+
	S269pClORppJQnOV6YluX/u8LE4xr9Fvu+SLZqQz+fxADxoV39PjkPOICpIPyVB/EOetsK3BP/l
	A4Qg0dgkww9KAUWUffOBTbzkfoAhqusPcwiyA8oDeoGVD8ocs/l0yY+0fvbEzsuHqUVRGlO243j
	AvauEAYpfRPLAA3aF/fgkfrTU5pmid2/uTEmnJ2+YgxytiiowDdjjXe1xqC22LAaxVuvInZt/R7
	KmvQvcFTZ0ERTDo7rB4Ijcwf6kCofE5uWierBGcz5a+wV21vWzYf+/uYOWDMFlgRW92Z9HCSQ+O
	c33bGEIzcRv4+BK1pjnM+806JxZG3jeUle7w=
X-Google-Smtp-Source: AGHT+IHficuxFrMnFN+Rk+trHWLoibEnKIefdrekPnY0DXmRibPCCevZfMnRJgOdu5b6m/yO4alZ1Q==
X-Received: by 2002:a05:622a:2b45:b0:476:977c:2eb0 with SMTP id d75a77b69052e-4771ddc8c90mr65433161cf.30.1742568059798;
        Fri, 21 Mar 2025 07:40:59 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d635ca1sm12560541cf.78.2025.03.21.07.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:40:59 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EE2A81200043;
	Fri, 21 Mar 2025 10:40:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 21 Mar 2025 10:40:58 -0400
X-ME-Sender: <xms:enrdZygOe6TlfJYX71gXF8kGGrwhrSdoyTxSTXMLdKFYnL4Mt0YEDA>
    <xme:enrdZzAT85tyf4fKhEDEuyeg10tNy8JpqwugnTIVbrkWm4ajr_fwe0NiFEK9Ts3WS
    YX1ABalwrw23Xd8OA>
X-ME-Received: <xmr:enrdZ6GjXBHfCR-zrfWlcledLpiTTtJ-vFehM3s-bOvD5V5qEN8auiZl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    rhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrg
    hfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhn
    fegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhloh
    hsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:enrdZ7S9w1oVsZ2E0ba2FZIb0PM5bkochXd1Lsop3GrYlZYLunyu7g>
    <xmx:enrdZ_xB-7d_PA55qmSP2X08xVO1SvXDZ44_FYwCwgk1ePJNTaCpvw>
    <xmx:enrdZ54cevD9X1P59JeaE0v-hT-znshE7skq5C984RjOUeWYxXVheA>
    <xmx:enrdZ8y0-fGWkEH7aiS1UCbVrNIms1xlXKZkfcaAYTAKitt_Ws1fPw>
    <xmx:enrdZ7gPgvx1oci5f_pZVIZKdRAyaii95hOeutbWO71ToFmVfzg5batT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 10:40:58 -0400 (EDT)
Date: Fri, 21 Mar 2025 07:40:57 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <Z916eZ1_Jd3VQz3Y@Mac.home>
References: <20250320222823.16509-1-dakr@kernel.org>
 <20250320222823.16509-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320222823.16509-2-dakr@kernel.org>

On Thu, Mar 20, 2025 at 11:27:43PM +0100, Danilo Krummrich wrote:
> Device::parent() returns a reference to the device' parent device, if
> any.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 21b343a1dc4d..f6bdc2646028 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -65,6 +65,21 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
>          self.0.get()
>      }
>  
> +    /// Returns a reference to the parent device, if any.
> +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> +        // SAFETY:
> +        // - By the type invariant `self.as_raw()` is always valid.
> +        // - The parent device is only ever set at device creation.
> +        let parent = unsafe { (*self.as_raw()).parent };
> +
> +        if parent.is_null() {
> +            None
> +        } else {
> +            // SAFETY: Since `parent` is not NULL, it must be a valid pointer to a `struct device`.
> +            Some(unsafe { Self::as_ref(parent) })

The safety comment also needs to explain why the parent device won't be
gone, I assume a struct device holds a refcount of its parent? Therefore
the borrow checker would ensure the parent exists as long as the Device
is borrowed.

Regards,
Boqun

> +        }
> +    }
> +
>      /// Convert a raw C `struct device` pointer to a `&'a Device`.
>      ///
>      /// # Safety
> -- 
> 2.48.1
> 

