Return-Path: <linux-pci+bounces-3382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16518529AB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 08:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BD0282F06
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DDE17556;
	Tue, 13 Feb 2024 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dnck7oN/"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F22F49
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808953; cv=none; b=JdBfxVc8bf+RXNcC5kqRUFI5+eCZKq/+ya0N4ELoFIRbzWWCwApP59Sh/5GS4MvZ2razy7GPuJXzwBO9lsOalOFq05Gm/d/07rq9KxnsFXebsKVIZlVaSej1EfYu1wHFAUSnAUW4aOWyvGuOnWBORev1syBdilSzkNJaNtizy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808953; c=relaxed/simple;
	bh=ozeZ7FqGPCKUWXvXyQuga6WAhbDvE50uGIz70z7K9Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdEroHtAouvOqEwresCjwSUwfcTupcBC0pLWbcKnVnKI+/nBddgAJqp1JARUWePPf3KNugF5KJdyYEYiaczy3TFJqNTIdJ0fYyOjaSIXbLqOfl/j3pTpvCUjd19oOYDZtlbZQqpvKiBLE7FLHwFJZ5MkWrl3QARLyan2o+AokuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dnck7oN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707808950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGhe/YEZnEtGdd9u8LC35GLq72EBNiME+lxjrDlx7s4=;
	b=Dnck7oN/f/6vkI7vPzMWS0xNL/b3BfQGQSutiJOi95ANpykANIuyfF7s2nYcG6PXPr0YzE
	7J7AeW9WTuuoAsmHab9LW0bufhhKjd1JzAfRpHjxV3uUK400A67veILi7D/puXybHIw5MP
	ran9nQWe4X8E4/R0poR1NTJG87xuZMY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-__2UURzlNMOhLhRifSZiSw-1; Tue, 13 Feb 2024 02:22:26 -0500
X-MC-Unique: __2UURzlNMOhLhRifSZiSw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c031e55ed5so3422968b6e.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 23:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707808944; x=1708413744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGhe/YEZnEtGdd9u8LC35GLq72EBNiME+lxjrDlx7s4=;
        b=X+hv9cDLb4vB19Jt44p7LAq8r/GDG7gHK7yk576cJEUgaAN4hI+g26fLOc748aO8af
         akk5HCrh8b3WqKu+hAsM2/YTuS4zOUZgHYuWT3UJPlhA79AkjA+5ZcGa64aZqQmaNewT
         Ym9k5gevPFOPtFO0oAQR9w3vupgZ/gqmGeiDpcBv1QKCH81vx4rA+acwSFujOA7Lqs6K
         +KPrxJGtT3pCK4Y0RjENqFPWszmJFynqkEBq9tI6J/ZqIFiJG7ZrPktZa3gGHLuwmALb
         aUm+Zpoqh7EIJszshB2xl7iDbejwkZc8I4jJJ8AW1XcAjqEb6uKa4lfAnpPRyhjmmKdR
         YNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpd0tN0twiRfet48+c0ir1bWMqWo49CZTV1kY5+owZ1kQDrAcOqvfmqcU2V1c6MeZvEmvp+2cmb22wpRxgZJcrggjEoKzjaBWt
X-Gm-Message-State: AOJu0Yyd8bsEaH5WBD1Y7BKd8YQmR5JI5zusYaftOcqj7Go+jbOFVe0D
	VYnSMGc/+cY4BQ5YoC/fpnvCxgG6zYcMBzD4zNV+4T09AIg7S1RwgNE2mDxqC+go9fmgeozh74T
	0WYW9ckCTtW0uxw33BMNQNWnDKS7yKDrer6dVFIlQDZJ9dA5Rc9LIt+Lq0g==
X-Received: by 2002:a05:6808:21a3:b0:3bf:e6c5:9b1f with SMTP id be35-20020a05680821a300b003bfe6c59b1fmr11167874oib.43.1707808943956;
        Mon, 12 Feb 2024 23:22:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEigHFXP+2h7Q/N0HEHy6RpNKMeeDNhg5ntkf8WvHxyDqYobAdFtx48sRQblZ+4wCHqA8X5g==
X-Received: by 2002:a05:6808:21a3:b0:3bf:e6c5:9b1f with SMTP id be35-20020a05680821a300b003bfe6c59b1fmr11167851oib.43.1707808943512;
        Mon, 12 Feb 2024 23:22:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkh3GDANAyn31CsDbSSGINl5Qk0DsLS4jKDouEEYysktm4LhSXTreW0BSz9bBaLGM2PH1TEXw8yWTuEJHZqD8SWq5kdBbCef6l9d6bMeylSPkPKn63WKKPyOi/JjGNr19PTQr8J7H2zkugFZyWkVY0e1BGY/KCCJUvL77FVgM/+q3/NPWcD1QD0c/RLfC4vDM4U8fP9fRmsy2vKTCH/FmNWQM0nH+UUll3hP+w8VHDuVMjETcmcWRK+PNel5D6bOBcDxGlMBIgXxIMZ7FPho0sNHelmYHzJojFGk9QQ/kaget2/zK7mO05b7eRzMMzPprfNBiAS7hOPim2q7uvGVPn1e8xPDzDY/BwyA==
Received: from localhost.localdomain ([151.29.75.172])
        by smtp.gmail.com with ESMTPSA id p9-20020ac84609000000b0042c7a76d267sm910557qtn.36.2024.02.12.23.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:22:23 -0800 (PST)
Date: Tue, 13 Feb 2024 08:22:18 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Georges Da Costa <georges.da-costa@irit.fr>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VI edition (OSPM-summit 2024)
Message-ID: <ZcsYqkkMa-4mk4G6@localhost.localdomain>
References: <ZbJHfiWnujLz2Pfm@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbJHfiWnujLz2Pfm@localhost.localdomain>

Hi All,

Gentle reminder that the deadline for submitting topics/presentation is
approaching: 19th of February 2024 (this coming Monday).

So, please go ahead and add your proposal to the shared doc

https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing

or reply in private to this email with details.

Don't hesitate to reach out if you need help!

Best,
Juri

On 25/01/24 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VI
> edition
> 
> May 30-31, 2024
> Institut de Recherche en Informatique de Toulouse
> Toulouse, France
> 
> ---
> 
> .:: FOCUS
> 
> OSPM is moving to France!
> 
> The VI edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Toulouse
> (France) on May 30-31, 2024.
> 
> We welcome anybody interested in having discussions on the broad scope
> of scheduler techniques for reducing energy consumption while meeting
> performance and latency requirements, real-time systems, real-time and
> non-real-time scheduling, tooling, debugging and tracing.
> 
> Feel free to take a look at what happened previous years:
> 
>  I   edition - https://lwn.net/Articles/721573/
>  II  edition - https://lwn.net/Articles/754923/
>  III edition - https://lwn.net/Articles/793281/
>  IV  edition - https://lwn.net/Articles/820337/ (online)
>  V   edition - https://lwn.net/Articles/934142/
>                https://lwn.net/Articles/934459/
>                https://lwn.net/Articles/935180/
> 
> .:: FORMAT
> 
> The summit is organized to cover two days of discussions and talks.
> 
> The list of topics of interest includes (but it is not limited to):
> 
>  * Power management techniques
>  * Scheduling techniques (real-time and non real-time)
>  * Energy consumption and CPU capacity aware scheduling
>  * Real-time virtualization
>  * Mobile/Server power management real-world use cases (successes and
>    failures)
>  * Power management and scheduling tooling (configuration, integration,
>    testing, etc.)
>  * Tracing
>  * Recap/lightning talks
> 
> Presentations (50 min) can cover recently developed technologies,
> ongoing work and new ideas. Please understand that this workshop is not
> intended for presenting sales and marketing pitches.
> 
> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!).
> 
> Registrations open on February 26th, 2024.
> To register fill in the registration form available at
> https://forms.gle/SooSmYMChBcn5rmM8
> 
> While it is not strictly required to submit a topic/presentation (see
> below), registrations with a topic/presentation proposal will take
> precedence.
> 
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation add its details to this list:
> https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing
> 
> Or, if you prefer, simply reply (only to me, please :) to this email
> specifying:
> 
> - name/surname
> - affiliation
> - short bio
> - email address
> - title
> - abstract
> 
> Deadline for submitting topics/presentations is 19th of February 2024.
> Notifications for accepted topics/presentations will be sent out 26th of
> February 2024.
> 
> .:: VENUE
> 
> The workshop will take place at IRIT [1], University of Toulouse [2],
> France.
> 
> The workshop venue is accessible [3] from downtown, where you can find
> most of the hotels/accommodations suggested below, by metro (line B) in
> 30 minutes [4]. You can reach IRIT by the metro B (approx one every 2
> minutes in rush hours) or by bus (several lines, between 40 and 60
> minutes depending on the line and the traffic). Several buses arrive at
> the metro station of the university. A map of the city center with the
> venue, transportation and food/drinks places is provided here [5].
> 
> It is recommended to pick a hotel close to a “Ligne B” subway station,
> anywhere between “Jean-Jaures” and “Les Carmes”.
> 
> From the station, choose “Ramonville” direction and get off at the
> station “Université Paul Sabatier” [6]. The station is right inside the
> university. From there follow the map [7] to reach the IRIT building
> entrance. 
> 
> Toulouse airport, “Aéroport Toulouse-Blagnac (TLS), Blagnac”, has a lot
> of direct flights from European airports like Paris, Amsterdam, London,
> Munich among others. There is a shuttle “La Navette” [8], every 20
> minutes, bringing you to downtown in more or less 30 minutes depending
> on the traffic. 
> 
> A list of hotels on the metro line B (direct to the workshop location):
> http://www.hotel-oursblanc.com/
> https://www.athome-ah.com/
> https://www.discoverasr.com/fr/citadines/france/citadines-wilson-toulouse
> https://www.pullman-toulouse-centre-ramblas.fr
> 
> [1] https://www.irit.fr/
> [2] https://www.univ-tlse3.fr/
> [3] https://maps.app.goo.gl/rdcrKx6x8ntm4uij6
> [4] https://maps.app.goo.gl/Y8UPRvHmbrjCSnvu5
> [5] https://www.toulouse-visit.com/interactive-map
> [6] https://metro-toulouse.com/ligne-B-metro-toulouse.php
> [7] https://goo.gl/maps/ojiAeQoL5Ewgb2gp7
> [8] https://www.toulouse.aeroport.fr/en/transports/public-transport?tabs4633=tab_4631
> 
> .:: ORGANIZERS
> 
> Juri Lelli (Red Hat)
> Daniel Bristot de Oliveira (Red Hat)
> Daniel Lezcano(Linaro)
> Georges Da Costa (IRIT)
> Tommaso Cucinotta (SSSA)
> Lorenzo Pieralisi (Linaro)


