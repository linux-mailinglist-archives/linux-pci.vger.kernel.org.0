Return-Path: <linux-pci+bounces-26826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCB8A9DC7A
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26833B81FF
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2825CC49;
	Sat, 26 Apr 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byRS9LQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFA12E7F;
	Sat, 26 Apr 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745687989; cv=none; b=Hw1lsFviWWllVHQPnRC1vaQkJBqH4VgQTiUHL4oNAPJJhadJ1rC3gwePqrsvre8M4NnHC4SEF0sMLjjnTUWBIRXQI+7xhq9M00FWOzL/241KDQS94ki4q5iTU1PhWi/gRHZw7tMLNabO/gS/gvKZ/jM6XKkozUOHTDqQo+k721s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745687989; c=relaxed/simple;
	bh=c5Le8ZEobH1qbEctBgs4t72H9Ggm5a5AZyV+cPlyxqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEh1uPVrPOWrqaER2IhRwHUhM30g5fNTcRQYLCz9Mu0SEkoWu4ogJWxIHfvVFh0K3Qlb/ze+AJUWrNSYRTUVsLxuo7THposWS2vZzsJ8qXz8JaPWZgFOM/sEynHPhWXeLcWzcA60ULgtocEkz9p/ijtu5rrG2FOlTtgPdnOLmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byRS9LQt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4766cb762b6so40107631cf.0;
        Sat, 26 Apr 2025 10:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745687985; x=1746292785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK/TDbxb2X5K00OclS68L8knPg1NMKWTxwXfQikrTpY=;
        b=byRS9LQtsPjDYhPO5S55GWXLuCJz/Kvn0GusGoKJG9KWo6ckx2NAL53KcFctWmQHjm
         XZQwLtxcC6SldmglL3gSBTBcck5k8zx8hzppgNVeZgBVkQmAYsCUCOKS6hvRgOovpjXx
         ipNCEEW5t+A5PZsEFwOJj2fNsyZ6BfSPj6ImHX954i0GDUVAanWpd4DQFnSIsGGGLk7o
         IjIU5GpPPxld/uKWdEVUi8fdD1xTTQhnv94UT+FhjssADxXoPztgm7Qhocv4KJz/stn3
         zrBbGaI8BKogmR9+eP6K4KOI2l60td6XQZzNeUCtVlWLuqr0BlkCeeIFh0pq23j4ffg7
         JfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745687985; x=1746292785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK/TDbxb2X5K00OclS68L8knPg1NMKWTxwXfQikrTpY=;
        b=T0tsqhn1QfM67dIAYZWNqcOYas4uxFVGCV0jhb2vz7N/aMIwFxpBDz2CyJ+IIHL174
         EM35ZugmWLFKvS0g7aExUu7WCkNe3Lz960Nmut4A3vjtzeArpdt6LQp/YCUAHoy/m2t8
         +W9xRPJD5Yp4dWoOC/GE7lbxW2ImwO9ebj9YlFpU6ZkdDi3OjfrTh87Jkh4Lz8YkQv1A
         N+ocAX/2xVAGrPFLTbe1+a/I4+wR0RyGJgi4nXRD6zOVcwywaewfyuI7fCedLA/2caG0
         UTHI7yWYdd0e0LeHaxUS8AhObq2lSqaB00NJpbgtmP6Vm8nGWlN5KKHfnq1rvXHlcwS4
         ROwg==
X-Forwarded-Encrypted: i=1; AJvYcCUnpg+LEFZal6biGlHgkWKbXcxVpKgoO8f+HB5DYhbv5ijN/sWRjh9AZ2HV60cwfftPqJJH8f7vCWSaEUY=@vger.kernel.org, AJvYcCWa6xYN/Vz4S4RzPpBamhpbfCr/Nc6i2Ry1bvznfUjNArRYGdwI5K4U955/PsNCf2gpqBChFYpn2XuA4Zhfo+s=@vger.kernel.org, AJvYcCXuRVl5GAGGkz6Dx6lHuNKQwK3m3Vi/5TSdMnhoJp3ecij1z/dJOIy+J8uFthx5iCug/p4j6YdYVLkf@vger.kernel.org
X-Gm-Message-State: AOJu0YxQob059TTfXqTUgTY1ZNpHA/NgpxuQB8pGC51bbRFihjpJMJhb
	vjhsEFMqe/0qyScO0OnKeGVaUYnqB3kFxVJiUXkuL5UFPSjIzidk
X-Gm-Gg: ASbGncvBsBCR9dzopI6t8umm2pMYsgjtJFxhvOuTp8zjKUaEIiSZLr0mLZlEAGeThk1
	zF3TmqN6rDHi/dnPnzy3vIdv9eYvum4RJaKkJqSsYukzBGbI4F7GFva6LP+YpMPe+JAP6IeJbuR
	3h0H158P0GNa8zL2GBQ47NdCnjXAxJBB0uJ44ROqF8Kj8e/z3pJdNwanbs6lAdf9s+aVhjL75O5
	0q8MYvUjemgnRnoIuhqKtXCExpNVZZGSufokfPQmllAYJZ2MD0bg5fbvOcbpAmrUlGe6RG/Fyx4
	OawaiRpx3ZLeR27cVZfk5+BuRgd/SuodGwgDPAg3EHCt/88X0umxZkafDLaR9G5UGmQjKTSlWX8
	BFT+bhDbDPTnngTr0ZDOjzWHNNOb6OQc=
X-Google-Smtp-Source: AGHT+IHNzAek2lfoMRtxfjUyRezjzdqtPNUtMArLCxJust8DO4LakM0Wsh1g2p7GvEZP2GZhF/ijnA==
X-Received: by 2002:a05:622a:1925:b0:474:fa6b:c402 with SMTP id d75a77b69052e-47ec4c0d252mr160960441cf.18.1745687985176;
        Sat, 26 Apr 2025 10:19:45 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f0d21a2sm41619771cf.27.2025.04.26.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 10:19:44 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25FBA1200043;
	Sat, 26 Apr 2025 13:19:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 26 Apr 2025 13:19:44 -0400
X-ME-Sender: <xms:sBUNaLMf4a4N8jmKjGK32WNiASFj-pd6RmRI_R_xaws-tGEtelIaeg>
    <xme:sBUNaF9tT3OsT26dGligpq2pxe0T55K_CXl0foWkR2wBWPys03wOUolchN2tucWAp
    eO15IpFBVCrRu25SA>
X-ME-Received: <xmr:sBUNaKRDCaLrVspc83RIlHoOO8jfJvjAvZBFCZd0Q2n_CpwzhfA43lR_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheehjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejveffleefvefgudejieeffeeklefgleeh
    heehvefhgeffkedvhedutddtjedugeenucffohhmrghinhepthhrhigprggttggvshhsrd
    hmrghpnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhi
    gihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhs
    ihdrshgthhhrvghflhesghhmrghilhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslh
    hinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkfihilhgtiiihnhhskhhisehkvghrnhgvlhdrohhrghdprhgtphht
    thhopeiihhhifiesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghjihgrsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehjhhhusggsrghrugesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:sBUNaPuQyiiCNiEe1ZJNbTODYOK1MozCMzewF1uMX-rbw0a531mSxg>
    <xmx:sBUNaDcBKeo5Z2riKdoi8RIwZgHcK4DBTEE4fqqt4cS_i_5TkFjqDA>
    <xmx:sBUNaL2KJ9zKMZpiiq5mk7xuS1YYfJwf9VR1_0asv8L7cSxe2NSDkw>
    <xmx:sBUNaP9xVYJ8cNCxWjHPpnlhEbokvu5ZU6YzwiC1-2IA2rF6QZI6rA>
    <xmx:sBUNaG9wkYTeZl9WOrttrBzuMRUUxN6E-zYjEyJzCUKtI5E8l2Sc7DsO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Apr 2025 13:19:43 -0400 (EDT)
Date: Sat, 26 Apr 2025 10:19:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
Message-ID: <aA0Vruu-rJWt146b@Mac.home>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-2-dakr@kernel.org>
 <aa747122-fc78-45db-a410-ceb53b4df65e@gmail.com>
 <aA0P4lr0A2s--5bI@Mac.home>
 <aA0RgOL09bBa0M19@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA0RgOL09bBa0M19@pollux>

On Sat, Apr 26, 2025 at 07:01:52PM +0200, Danilo Krummrich wrote:
> On Sat, Apr 26, 2025 at 09:54:58AM -0700, Boqun Feng wrote:
> > On Sat, Apr 26, 2025 at 06:44:03PM +0200, Christian Schrefl wrote:
> > > On 26.04.25 3:30 PM, Danilo Krummrich wrote:
> > > > Implement an unsafe direct accessor for the data stored within the
> > > > Revocable.
> > > > 
> > > > This is useful for cases where we can proof that the data stored within
> > > > the Revocable is not and cannot be revoked for the duration of the
> > > > lifetime of the returned reference.
> > > > 
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > ---
> > > > The explicit lifetimes in access() probably don't serve a practical
> > > > purpose, but I found them to be useful for documentation purposes.
> > > > --->  rust/kernel/revocable.rs | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> > > > index 971d0dc38d83..33535de141ce 100644
> > > > --- a/rust/kernel/revocable.rs
> > > > +++ b/rust/kernel/revocable.rs
> > > > @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
> > > >          self.try_access().map(|t| f(&*t))
> > > >      }
> > > >  
> > > > +    /// Directly access the revocable wrapped object.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
> > > > +    /// for the duration of `'a`.
> > > > +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
> > > I'm not sure if the `'s` lifetime really carries much meaning here.
> > > I find just (explicit) `'a` on both parameter and return value is clearer to me,
> > > but I'm not sure what others (particularly those not very familiar with rust)
> > > think of this.
> > 
> > Yeah, I don't think we need two lifetimes here, the following version
> > should be fine (with implicit lifetime):
> > 
> > 	pub unsafe fn access(&self) -> &T { ... }
> > 
> > , because if you do:
> > 
> > 	let revocable: &'1 Revocable = ...;
> > 	...
> > 	let t: &'2 T = unsafe { revocable.access() };
> > 
> > '1 should already outlive '2 (i.e. '1: '2).
> 
> Yes, this is indeed sufficient, that's why I wrote
> 
> 	"The explicit lifetimes in access() probably don't serve a practical
> 	purpose, but I found them to be useful for documentation purposes."
> 
> below the commit message. :)
> 

Sorry, I overlooked.

> Any opinions in terms of documentation purposes?
> 

I think for access() the explicit lifetimes is unnecessary, because it's
a one-lifetime case, the two explicit lifetimes would make a simple case
looking complicated.

For access_with(), that's needed and a good idea.

Just my two cents.

Regards,
Boqun

> > > 
> > > Either way:
> > > 
> > > Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> > > 
> > > > +        // SAFETY: By the safety requirement of this function it is guaranteed that
> > > > +        // `self.data.get()` is a valid pointer to an instance of `T`.
> > > > +        unsafe { &*self.data.get() }
> > > > +    }
> > > > +
> > > >      /// # Safety
> > > >      ///
> > > >      /// Callers must ensure that there are no more concurrent users of the revocable object.
> > > 

