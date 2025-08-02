Return-Path: <linux-pci+bounces-33331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD2B18EC8
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 15:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921BC17766C
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054E23BD0F;
	Sat,  2 Aug 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EzeXwANA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E523ABBF
	for <linux-pci@vger.kernel.org>; Sat,  2 Aug 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754142639; cv=none; b=Kl4kRTLQOk1JPy4N1egRsIh4EAo719/c1AChkEcnfjvlIrJBHLGFGTrWtAaDOMEb01Hcthu/IL0WRASfg9bxGy2t/65y7HCDHiTkZcrndH05satqh6O6GT1OOiW0kEeXd5VLcR8r6r5V4ja6Ltb/8MlbGRJnQh6oiprkw9nxABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754142639; c=relaxed/simple;
	bh=LuZKFpWuGGzaZA5PO666vYIpjfV7fVYnGa8m+zu7hYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZkI0mWPhll7AoP4Q761vx7qZ6y5qxFcf2N6zkR8ZvVv45t3AZ4EIlFXJYCjtIuNIEJO8kB4KfgqnWx7QsYnwMbVm+3QoK6xkhUMJiWjndDA/+lUNGeAWk6Ezremxe4Ol5gWMdrH+sBv/QlmiaANQjhyJXEEpaC7hzCo4cEn6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EzeXwANA; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4af14096b9eso9566331cf.3
        for <linux-pci@vger.kernel.org>; Sat, 02 Aug 2025 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754142636; x=1754747436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fuk2lxrqPOrpRrouda4o7p4C2uIw6lx4ISriZi45ts4=;
        b=EzeXwANA/LFJXeWiL5EANqVgjd7j0bHOI7NqR1mJQQcXrf09J8mV3uZhixOipku761
         QTLqZEwdsbGnSwDuR070Elu+R645I0zWgFv7WK7v8Fn0EsQXr8rgiU4+M6C5X/o2ozfn
         uBB60cLP9ayh2ZC/EYMkpyuUKYchCEgs/knhRiOzFRhPI5QTUsr6ZyMMgtY2kmfuxxR5
         bU9aR95ybjVhVQa4+B0lS6z4e9mpt971cm+O2pKxXgp2q4OKGSxugg2010dG7n43Dh4/
         aR/HBjsVWWVFIR9KZ3n9PHYwkiSFvPfsRpUbvKAgiPQ9PcYnw7jM1BbmYQ220WzhB6eU
         xD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754142636; x=1754747436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fuk2lxrqPOrpRrouda4o7p4C2uIw6lx4ISriZi45ts4=;
        b=bWtQiZAXiUJVLUvjI+5g15VjHI4kmkBXlIecoPIqzoGLMbEsMD5h6IaPtqlN5CT26w
         O6vUf5DsiQk8so9B9loqLDrog/xM/W9T3YrBzPHs2mAppkDjoWaNu3ylkTofYQox137w
         BsIEuGzvV1P5pBAPOWP43rvkJ1n4lPAIR+5H+s1yGzqRU35QP7kLA/8kBnUCHg3in/bO
         kOYDU/2C9oBNZvShXq3Mn85b6pXEQEbZW+vHW0nqe62RqJPI6UpCTAXUX2EDZecZpAtC
         LZYit8q/ufvxJlFrYE/3vmm1QMuxuvVBS1Tl/xpPjVAmSNc+S+4g10mJLgar50/if6iO
         MSnw==
X-Forwarded-Encrypted: i=1; AJvYcCU84Hb5Hqr5u7S649lvXMUVDcHYq1fC8poIggHrAdBPYBlhwmprCqQPD5vaRp+rvBYJD5yQCjqxbZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIfisBGj3PWpm8PaJSnY2GHqPgW+nZLGCMP+sQ+rwOjP9KQ54
	V+oQtzNhx2Z+QDD1Fb7ZrX8aSGIfrE5niOwrIhuFAxvKy/0YG/dpX+VcMzEs8SYjDx0=
X-Gm-Gg: ASbGnctrLkzzGeAgThAaIlwSQkosnamobutuhFzTd+LIVsMkck9Ml8g0zgW5nTe+T2V
	7SbfxEcE1ENw2tomBA0qXtnXRSrhXkXXNVpIxlg9QaO20dCtIcnBVOJfAsZBD2vOuN2EhU91/L8
	TR4q270QdnmduvuztzBojqjmxtcqhjNqfw+efdo6fqSS1WzzG6mXFB70deD4CXa3qx6v08wCWwI
	8UKVyWiT0GlJ/POIcPOzEcNwYm3ekUvE4H71MIR0gwqzR83GubcTzMBRUtcyXDF/PcHYCU+dSJY
	j5l2HHQjD/mPwScn6ZdKyZLVbo+q+Eyva2zTbyUmhOo8fPt33r/kIiccsfAR+nuIAXsgCklenQR
	L367rkZgKtoqCEkKALSpBYHZMh4Xh9EOC54ITag0vrGgo+btcyc21//qTqxzluSJo8V/3
X-Google-Smtp-Source: AGHT+IEpsAH58cOIvisp67GeJBP3mYHAiMC91cTAnICy/rrQ4pDbqvjQWBKRPW9T1q+TGAIxQC7cxw==
X-Received: by 2002:a05:622a:1aa6:b0:476:875e:516d with SMTP id d75a77b69052e-4af10aabea4mr38643861cf.36.1754142636187;
        Sat, 02 Aug 2025 06:50:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d8affsm34886696d6.5.2025.08.02.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 06:50:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uiCd8-00000001A65-3qAw;
	Sat, 02 Aug 2025 10:50:34 -0300
Date: Sat, 2 Aug 2025 10:50:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at
 boot
Message-ID: <20250802135034.GJ26511@ziepe.ca>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org>
 <87zfconsaw.ffs@tglx>
 <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>
 <20250731150132.GV26511@ziepe.ca>
 <CAF8kJuPbJWea+o=GTFEM6KRCq4DxDad+83+vM0Np+n=Mmzqzag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuPbJWea+o=GTFEM6KRCq4DxDad+83+vM0Np+n=Mmzqzag@mail.gmail.com>

On Fri, Aug 01, 2025 at 04:04:39PM -0700, Chris Li wrote:
> My philosophy is that the LUO PCI subsystem is for service of the PCI
> device driver. Ultimately it is the PCI device driver who decides what
> part of the config space they want to preserve or overwrite. The PCI
> layer is just there to facilitate that service.

I don't think this makes any sense at all. There is nothing the device
driver can contribute here.
 
> If you still think it is unjustifiable to have one test try to
> preserve all config space for liveupdate. 

I do think it is unjustifiable, it is architecurally wrong. You only
should be preserving the absolute bare minimum of config space bits
and everything else should be rewritten by the next kernel in the
normal way. This MSI is a prime example of a nonsensical outcome if
you take the position the config space should not be written to.

> > Only some config accesse are bad. Each and every "bad" one needs to be
> > clearly explained *why* it is bad and only then mitigated.
> 
> That is exactly the reason why we have the conservative test that
> preserves every config space test as a starting point. 

That is completely the opposite of what I said. Preserving everything
is giving up on the harder job of identifying which bits cannot be
changed, explaining why they can't be changed, and then mitigating
only those things.

> Another constraint is that the data center servers are dependent on
> the network device able to connect to the network appropriately. Take
> diorite NIC  for example, if I try only preserving ATS/PASID did not
> finish the rest of liveupdate, the nic wasn't able to boot up and
> connect to the network all the way. Even if the test passes for the
> ATS part, the over test fails because the server is not back online. I
> can't include that test into the test dashboard, because it brings
> down the server. The only way to recover from that is rebooting the
> server, which takes a long time for a big server. I can only keep that
> non-passing test as my own private developing test, not the regression
> test set.

I have no idea what this is trying to say and it sounds like you also
can't explain exactly what is "wrong" and justify why things are being
preserved.

Again, your series should be starting simpler. Perserve the dumbest
simplest PCI configuration. Certainly no switches, P2P, ATS or
PASID. When that is working you can then add on more complex PCI
features piece by piece.

Jason

