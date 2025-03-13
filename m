Return-Path: <linux-pci+bounces-23647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5894A5F874
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B51EC7AEDB1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2D267F5C;
	Thu, 13 Mar 2025 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jdH5v5x6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE68267B0E;
	Thu, 13 Mar 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876319; cv=none; b=DgCAoZDaiMaI0GZ/OXp5+7tqVGD5Ic6FAb9KEEQXf4MWp/+BuArHiLvONBUcCudE5qPz6WNItdOuPosExfk6IHur/EtTF1XyOztZvWBY7Pl9KEDXl9X3HqGg87w3QeA4f/utRFN04JP2xyiJengZB64I3myjMN/65+PCL/AtMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876319; c=relaxed/simple;
	bh=+UhJ8L9nPlPqg262SFohjz7Kn3vgi4V7dp5/CfiDbkM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdW7Gc00Bjs3Vrhsn+aqLGO8oNPeu3NNXaiE6zmSddfUzaw63qs6EmpJRqpvbpumSsSgxukARfNHMUY/W+EyYfE3YW+0ooH3S7zQcAtb+qFGmMj+vQ2hXv42GJmlTQYHv9+SZm0K0QSng69HInua3cjNuJs/yfK2XGj7G/0MUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jdH5v5x6; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741876315; x=1742135515;
	bh=+UhJ8L9nPlPqg262SFohjz7Kn3vgi4V7dp5/CfiDbkM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=jdH5v5x6O8SResdpg5Oq2gsj44vUlfyycErmvGpZfP0Qbt9JD7TXOXgyMtPryebgJ
	 LHvcveZEhTZlGuMmuNlraNdL+gwuRje7cA7cQ/n7BVfHd4YubvM43NOUTwZylRcyr1
	 eIJeCCbmjPCkhYbLcDkp70PLp7KLSA3NcSOQ6pZMLWWvKbIIJSPoeGz/sGtcGibxvT
	 t7/annbZoX8+kc0aBDW6C1FAAku6z1lCI2/kIHy0bZLvclCoDg7/l9cqF4N1l5LsYd
	 Yosk6nn4APrhkhkYK6Oy8ZgY3QBWbZeB+OV5GFFEvTHOHidDDtELnTUaVfcbRA7of9
	 M7VtUdFbYqbcQ==
Date: Thu, 13 Mar 2025 14:31:49 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: device: implement device context marker
Message-ID: <D8F7M6X56LAC.2WEKCTQ40X72Z@proton.me>
In-Reply-To: <Z9Lpx9K7ThuEqGEM@pollux>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-3-dakr@kernel.org> <D8F2GQ4WYT7Z.172Z7R7V8BIGR@proton.me> <Z9K2PJEoymuhamT-@pollux> <D8F2YBFHCTFL.3TH1E0TB11EHU@proton.me> <Z9Lpx9K7ThuEqGEM@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b20a8e1dd34d5d759ff122d5a41db74447706fc3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 3:20 PM CET, Danilo Krummrich wrote:
> On Thu, Mar 13, 2025 at 10:52:34AM +0000, Benno Lossin wrote:
>> On Thu Mar 13, 2025 at 11:41 AM CET, Danilo Krummrich wrote:
>>=20
>> > However, we can always change visibility as needed, so I'm fine making=
 it sealed
>> > for now.
>>=20
>> Couldn't you just add them here? Then sealing wouldn't be a problem.
>
> Yes, but I wouldn't want bus specific stuff to reside in device.rs.

Sure, we can always make the sealed trait crate-public, since my main
concern is that a driver author tries to add a new context.

---
Cheers,
Benno


