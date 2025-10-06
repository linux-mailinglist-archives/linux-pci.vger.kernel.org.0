Return-Path: <linux-pci+bounces-37624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B6BBEFB5
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 20:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA553C69FE
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497D7283FE3;
	Mon,  6 Oct 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PujDmGmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A42376EB
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775563; cv=none; b=Qsrc0o1yMfwMRpCdFyNTk/91ctDFRT6V4IsH5a4jx7TiG8wYv9n31Qp22TrsoFh3jiGCs0O0pNIO2oZQ5sfN3X8SEwwjOip5hKu0ZUF5r74z6jMqU05qwtGyDdpP8TLeamuESvyLFoKysbxm2/3wmT/kwo0Tweahj9cg0sYCg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775563; c=relaxed/simple;
	bh=Dj6m4vh4I+aSGB7esG1Hx/YYkGrqbAo4J1raPd5acaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAAkv58KzcmNP19spfaB2Mqc0z0D3oYktRRtjj2WcfrfhQ3/Ujm56Kb4++Jko4G6/FkvpZjxpqcpJRX5Gd4hphscNMn6bwELRTkglOnZYfhJ8oEp0YGGs9HaGRowRp9Id5VXeZxpu9lC0oYzkRYUP3FLo0TJ83GLY5/vb9A6Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PujDmGmS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d3540a43fso55108025ad.3
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759775561; x=1760380361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwSuYHyPWLnd4B0J2NLg4Ynddq4RJZuyBAc+JpL56Y0=;
        b=PujDmGmSuclp/MSAl7Ki7Ge2233hL8EypmdA+14CW5MM6nNOSsqeebkCSafiFVoVVr
         ANxVwvxEH/JfPgFzT4W8KOUCtVzVQlIDpM7LdWCSJO1Bk3gFsThmrIy4jHrhQe4HpFzZ
         95gfPN844C3T4D2sbVqAsh6DRbIHZXw7pgYng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775561; x=1760380361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwSuYHyPWLnd4B0J2NLg4Ynddq4RJZuyBAc+JpL56Y0=;
        b=jbv6UKmedXlGE2nTMXVNgQs0Z13TeGziDtj7VPf6tZsqRtB/bisFkCskXLKp2a9Qnk
         84g9KUPMmwhdXnMqeEhHAGpd9AuJ7YvtYnfDSbN+2lK2+kv1PcCgARV+ti7bCePT0t2T
         4LrfVRB/E6i3VPWRoOQ2OCC3mgeohxYFN1wkambQJdx0YV6ngoxqEvewSVBrFRMIcaFf
         wcm0el1GNPqC2dXiw0qdXfo7jnvCw96s6LomaFPpl8K9xsFsXOdvlLcIOdtfT/stJWQf
         8/SOOgI77Mrx5xPQIHEKJZtkY2dqWs5lkwqgchRiH/oAsv1nPb/+aYIrCrrt1U4YE0Dy
         RrJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOaM+9ff5WSLJPNC/bibx48lu2mTX7FdLXFSFv/0X/TdKb6Db/TQfQbmLsE5E9wA3vMCdvd+Tp+RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0QUf5h9FWcfBzG5jdFgxEMGn24IG0yqaw8YQKSicLbdArsB3
	GX0dGqATwv5czrV+yaeuHfaArPWr2cSTFteKgHq1Ntxf6L1H23Gh6nzCGJLsty371A==
X-Gm-Gg: ASbGnctOPblfiPMLnXRB8iwfDpdko54tdQVYKirZMytNpSfINYZDUsbfAoQlQ+Nzw4/
	OUU6wxnw6ZjxWb5XbQ3sEufP6xlWfIFXf4llQ7pWA/t454WN45rqk31Oe68b0d4CgkWS4Lk2b3w
	11wQXK1wKSGuGSDRSDmPjatvhaEmbruWKxE19NDKsnj/VvvvOL7523OSsemu/qhJMv6F6l1E18T
	B/cLgEIW7vh/vYGYN5jT41eWEVaTqwF102ubz/Y3aafpEdUn/7NVkqo87S3s2CmcavlKVj763Vw
	tsw2mIfvb0S0xEDupa3uQzkREK/L+GePVPXLhd0iJgrKm8GRJT32jkdGOJ4o1YDTN+qsUOX3+/H
	uAkMBmDvapWtqazr8n/3Ne1cj41tcmUq5It1MJhuD2iz8jxNh7IUvZ0SoXVUY8gY8jDtjUItMm6
	AHqoAaJBIbZwLuRKfqKYE=
X-Google-Smtp-Source: AGHT+IHyUh9+Wdk2VWGp0HemaJgNqqUfeJ8XAjYRPDqgSqGja/q3alk2W+weivII4Y0JLs+WqyHOXQ==
X-Received: by 2002:a17:903:3c65:b0:269:8072:5be7 with SMTP id d9443c01a7336-28e9a6654c0mr169220315ad.56.1759775560991;
        Mon, 06 Oct 2025 11:32:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:299e:f3e3:eadb:de86])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1108c5sm140090835ad.16.2025.10.06.11.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:32:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 11:32:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <aOQLRhot8-MtXeE3@google.com>
References: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>
 <20251006135222.GD2912318@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006135222.GD2912318@black.igk.intel.com>

Hi Mika,

On Mon, Oct 06, 2025 at 03:52:22PM +0200, Mika Westerberg wrote:
> On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > When transitioning to D3cold, __pci_set_power_state() will first
> > transition a device to D3hot. If the device was already in D3hot, this
> > will add excess work:
> > (a) read/modify/write PMCSR; and
> > (b) excess delay (pci_dev_d3_sleep()).
> 
> How come the device is already in D3hot when __pci_set_power_state() is
> called? IIRC PCI core will transition the device to low power state so that
> it passes there the deepest possible state, and at that point the device is
> still in D0. Then __pci_set_power_state() puts it into D3hot and then turns
> if the power resource -> D3cold.
> 
> What I'm missing here?

Some PCI drivers call pci_set_power_state(..., PCI_D3hot) on their own
when preparing for runtime or system suspend, so by the time they hit
pci_finish_runtime_suspend(), they're in D3hot. Then, pci_target_state()
may still pick a lower state (D3cold).

HTH,
Brian

