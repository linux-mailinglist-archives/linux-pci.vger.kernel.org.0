Return-Path: <linux-pci+bounces-5753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5489924A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 01:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D1328A513
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 23:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434C013C3DE;
	Thu,  4 Apr 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW3iyFrT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB6130E57;
	Thu,  4 Apr 2024 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274602; cv=none; b=jGUbbbrSat6klHepWTKi2LjreqFI/8Y1xROs/7CkMN9O2HZt5r3TVz1gHiHMGM3qWWzLPrtQ6shLenBdX23cdhj3kmHBYELJCgQxRnX/A6EkXwgLJj1OF4oaOAknarSalMtq7GFJ8ivunhVhh55PKW9R40rYDKYwdOrjyEd+g+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274602; c=relaxed/simple;
	bh=Jqs8/bW3s9On1aKz6wq7MyfoYbFpqdDk6dTGzHGqJAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ajldga0GBkEh5DgQH6xaDF7JiszW1MazzgEKKVUh6ktVDAck5Wy6AshNiEul2Z+vKKNFkbeRQUtsvy4W3aSXVsAttfLcBXWSeWQAtH63waLnvZjKhVsccWdfiQUC7QEExwWn1b9zjVJDLGKsL9cURC4zSSzT1rGTBLmQ+K3RoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW3iyFrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29949C433F1;
	Thu,  4 Apr 2024 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712274601;
	bh=Jqs8/bW3s9On1aKz6wq7MyfoYbFpqdDk6dTGzHGqJAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NW3iyFrTCk1r7ZbMM/lqcHH0QbfeKHQnRCArw5qVThFOBF7Emb2dcA7/wZnBZx+f9
	 BVztE4gFGiaoz7Js5ePFaj/ahOh4bqYA3lrF1kMOtbH87Qt0rThrtaHNtxRBJhn2vS
	 uTL20RF0WMQA4lDsw3nBrSccDxViB1IpofrnZl64J4vh9ZfUo0uTq3NDbetOnJ7Qjx
	 FEH4jOipbZVd5GTCyIGWbSi91MMCzwBgjRj4W7ep9Y1jEvHoI1aSBzNMkw+3aJhCLO
	 1HMXqVomG7p9wsf+McRjv/oDsfD/i2KdYU2uEVkVbJpKSR4lVCGD7IcbDS36JU9E6E
	 qMcbRuk9zbQAw==
Date: Thu, 4 Apr 2024 16:50:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240404165000.47ce17e6@kernel.org>
In-Reply-To: <660f22c56a0a2_442282088b@john.notmuch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<Zg6Q8Re0TlkDkrkr@nanopsycho>
	<CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
	<Zg7JDL2WOaIf3dxI@nanopsycho>
	<CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
	<20240404132548.3229f6c8@kernel.org>
	<660f22c56a0a2_442282088b@john.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Apr 2024 14:59:33 -0700 John Fastabend wrote:
> The alternative is much worse someone builds a team of engineers locks
> them up they build some interesting pieces and we never get to see it
> because we tried to block someone from opensourcing their driver?

Opensourcing is just one push to github.
There are guarantees we give to upstream drivers.

> Eventually they need some kernel changes and than we block those too
> because we didn't allow the driver that was the use case? This seems
> wrong to me.

The flip side of the argument is, what if we allow some device we don't
have access to to make changes to the core for its benefit. Owner
reports that some changes broke the kernel for them. Kernel rules,
regression, we have to revert. This is not a hypothetical, "less than
cooperative users" demanding reverts, and "reporting us to Linus"
is a reality :(

Technical solution? Maybe if it's not a public device regression rules
don't apply? Seems fairly reasonable.

> Anyways we have zero ways to enforce such a policy. Have vendors
> ship a NIC to somebody with the v0 of the patch set? Attach a picture? 

GenAI world, pictures mean nothing :) We do have a CI in netdev, which
is all ready to ingest external results, and a (currently tiny amount?)
of test for NICs. Prove that you care about the device by running the
upstream tests and reporting results? Seems fairly reasonable.

> Even if vendor X claims they will have a product in N months and
> than only sells it to qualified customers what to do we do then.
> Driver author could even believe the hardware will be available
> when they post the driver, but business may change out of hands
> of the developer.
> 
> I'm 100% on letting this through assuming Alex is on top of feedback
> and the code is good.

I'd strongly prefer if we detach our trust and respect for Alex
from whatever precedent we make here. I can't stress this enough.
IDK if I'm exaggerating or it's hard to appreciate the challenges 
of maintainership without living it, but I really don't like being
accused of playing favorites or big companies buying their way in :(

> I think any other policy would be very ugly to enforce, prove, and
> even understand. Obviously code and architecture debates I'm all for.
> Ensuring we have a trusted, experienced person signed up to review
> code, address feedback, fix whatever syzbot finds and so on is also a
> must I think. I'm sure Alex will take care of it.

"Whatever syzbot finds" may be slightly moot for a private device ;)
but otherwise 100%! These are exactly the kind of points I think we
should enumerate. I started writing a list of expectations a while back:

Documentation/maintainer/feature-and-driver-maintainers.rst

I think we just need something like this, maybe just a step up, for
non-public devices..

