Return-Path: <linux-pci+bounces-18599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0D39F49C0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 12:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EEA1663C8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085821EBA07;
	Tue, 17 Dec 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrgmId60"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22541DE3C5
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434601; cv=none; b=CAJZ33IjPMJmV4IxTaMgys+DisoZH1AbO2MnoLDxW/uX1uny/94MgRYoHAtRgIHtpqA3hwFynn6FyzGnId52RQh79d9yD+yssI0o0AnTOxVOhbyvi0ThG4kjIUq1LLf2mRQbRK8GnlgSMxuRlkGGhWoDR/Fx1n+9iw85k+cJDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434601; c=relaxed/simple;
	bh=RmSIt/3Ns4FBCqw8NFpzWMRkTFrQMhrc2MyPlmAiKwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4bWtVgl5ek3Y7kKiz6ze7wfnbsGSCXgFaJt/IfJwVWZ0vdaqHIvz57YGRljy/p4TPQwtpnKz9JVXDNnLyvKmbA/YA+ivI0yzhrrYSr3FHs8USivLq7r0S47NmjaVXKnKgU7gjaKp9CMcZXEYByzEvLT8W3GYJVtGK6plDiWJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrgmId60; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734434598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxFk4ZzElKHondedZg8yku+jbtm7e4uZWvmWgn/Up8c=;
	b=QrgmId6031O5nKva+9Rq1OfMvrOLt8UC0ofwNm59rul05TGQK+fAXckEdyAyXmQAt+v3am
	WZrGNS60yfzvgx8LjN9G4A/HQ0rq51Krw3bfwZtBWpg5rBQ4BQwaLRJwP6AHTnVu3D/7gy
	El8+ZisfCh555vb0nK99sMPbQq+7sfQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-KMyi-7GnMb2UBRFvLSAZDQ-1; Tue, 17 Dec 2024 06:23:17 -0500
X-MC-Unique: KMyi-7GnMb2UBRFvLSAZDQ-1
X-Mimecast-MFC-AGG-ID: KMyi-7GnMb2UBRFvLSAZDQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467a409b8ddso82437171cf.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 03:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434597; x=1735039397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxFk4ZzElKHondedZg8yku+jbtm7e4uZWvmWgn/Up8c=;
        b=PSNgoS25kRoteDf78QgLIclt4EvBfE3L4ZQ60g2K6C5g7yzIVdei7UgpZg56crETxO
         u+bnOxBhaH8TziDsrwl3u/9mbTNXW8/WoOPa70PTKR7WhvYYgRaGIcmj7QHliO1JZU0X
         XtblBFaNZIck+xruHRMoZJpW+921eXsuJzYqkXSssKZtBRN9lWURXey9PmG6/+v/2FzP
         FSuVkgdkHyiOavJxSOdI8rJdtT7/i+3hQVv1oKhSR3GxxGTodk4vuIQtZhZjizVYnlsZ
         filHWrYnevH48CUJi7ITbhw4OpT0gxnDmzg0GZMdY6lbY+vIuQoVOfUlcHoWBuuqa6DO
         S1rw==
X-Forwarded-Encrypted: i=1; AJvYcCWnI9Lw+wiT3Dk4GO1MxxGWD8uGX3czgk3u3Q6tYSTl8OXDjr/VCkcHoLhPPS6vY5YRGutREpuU6jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbfVkOx/byeCawB0a6X+LWSBWsg/7DMm7SDvD5YsDWSXEvwio
	wFpsJmmYGLENLIX6E6zRnkHbtyqZnLDVvZgBJViuQriMYeEIkD/M+WfdLFvZlw6d/kM20LIVDKp
	GR0rzPeV8GGEYcXSnmVoOChbZgciVbC6L+kGmGmOli216htKYeOqR9LQ/5A==
X-Gm-Gg: ASbGncvlGtNsWa9YABpz8AtitViv8q0g3r2WiTLjqoubiyU9L08/QiAwxjbdqvHAzxx
	TFfU8yV2DBCpbdp7JoGsu6cRQOP6Nryy9GjK5+uuwf2zAF+bdiLtttIoz86zfhpR8gGpMrpztLP
	28Qxcx+B+RpUU2Srj6wMgaED+/D6FAe/R995Ea0qvs8PNgUrCt/n0yR7JhtWYg7gyfbnLJs7y+k
	24iqVQ4SBW32x4JcAdDL6j9bfHOGFJrmoQL4ZzrXVe6gjgjq3n4vlgpVtR/6FYhEEHZ8BOIYtk+
	HnSggMjTNHcuEmDLNtPTSbpSb9A7HD1hvBaAWPVjDwk=
X-Received: by 2002:ac8:7c49:0:b0:467:603d:1cd5 with SMTP id d75a77b69052e-468f8dd49eamr46825241cf.26.1734434597069;
        Tue, 17 Dec 2024 03:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDlnfHsZwL618rCmU7oi6Y1uHEhl66Xxg1NEAZrBlzi7MfB/k934xEyHJarN/SUCDyDssw+A==
X-Received: by 2002:ac8:7c49:0:b0:467:603d:1cd5 with SMTP id d75a77b69052e-468f8dd49eamr46824991cf.26.1734434596710;
        Tue, 17 Dec 2024 03:23:16 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-40-237-196.as13285.net. [80.40.237.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2c72fa9sm37976241cf.12.2024.12.17.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:23:15 -0800 (PST)
Date: Tue, 17 Dec 2024 11:23:11 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Frauke =?iso-8859-1?Q?J=E4ger?= <frauke@linutronix.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Registration open for OSPM-summit 2025
Message-ID: <Z2FfH3JK7yMt20Td@jlelli-thinkpadt14gen4.remote.csb>
References: <ZytlAkTiuZApK23Y@jlelli-thinkpadt14gen4.remote.csb>
 <Z02EBA_0SwWPhTAi@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z02EBA_0SwWPhTAi@jlelli-thinkpadt14gen4.remote.csb>

Hello,

Last reminder for this edition, promise.

Registration is now open!

Please use the following form to register

https://forms.gle/Yvk7aS79pvNR6hbv8

Please share the word and see you soon!

Best,
Juri

On 02/12/24 10:55, Juri Lelli wrote:
> Hello Everybody,
> 
> Quick reminder that deadline for topics submission is approaching
> (December 9, 2024 - next Monday).
> 
> Please use the form to submit your topic(s) or reply to me privately
> with topic's details.
> 
> https://forms.gle/Vbvpxsh8pqBffx8b6
> 
> Don't wait until last minute or Santa will add you to the naughty list!
> 
> Best,
> Juri
> 
> On 06/11/24 13:45, Juri Lelli wrote:
> > Power Management and Scheduling in the Linux Kernel (OSPM-summit) VII edition
> > 
> > March 18-20, 2025
> > Alte Fabrik
> > Uhldingen-Mühlhofen, Germany
> > 
> > ---
> > 
> > .:: FOCUS
> > 
> > OSPM is moving to Germany!
> > 
> > The VII edition of the Power Management and Scheduling in the Linux
> > Kernel (OSPM) summit aims at fostering discussions on power management
> > and (real-time) scheduling techniques. Summit will be held in Uhldingen
> > (Germany) on March 18-20, 2025.
> > 
> > We welcome anybody interested in having discussions on the broad scope
> > of scheduler techniques for reducing energy consumption while meeting
> > performance and latency requirements, real-time systems, real-time and
> > non-real-time scheduling, tooling, debugging and tracing.
> > 
> > Feel free to take a look at what happened previous years:
> > 
> >  I   edition - https://lwn.net/Articles/721573/
> >  II  edition - https://lwn.net/Articles/754923/
> >  III edition - https://lwn.net/Articles/793281/
> >  IV  edition - https://lwn.net/Articles/820337/ (online)
> >  V   edition - https://lwn.net/Articles/934142/
> >                https://lwn.net/Articles/934459/
> >                https://lwn.net/Articles/935180/
> >  VI  edition - https://lwn.net/Articles/981371/
> > 
> > .:: FORMAT
> > 
> > The summit is organized to cover three days of discussions and talks.
> > 
> > The list of topics of interest includes (but it is not limited to):
> > 
> >  * Power management techniques
> >  * Scheduling techniques (real-time and non real-time)
> >  * Energy consumption and CPU capacity aware scheduling
> >  * Real-time virtualization
> >  * Mobile/Server power management real-world use cases (successes and
> >    failures)
> >  * Power management and scheduling tooling (configuration, integration,
> >    testing, etc.)
> >  * Tracing
> >  * Recap/lightning talks
> > 
> > Presentations (50 min) can cover recently developed technologies,
> > ongoing work and new ideas. Please understand that this workshop is not
> > intended for presenting sales and marketing pitches.
> > 
> > .:: SUBMIT A TOPIC/PRESENTATION
> > 
> > To submit a topic/presentation use the form available at
> > https://forms.gle/Vbvpxsh8pqBffx8b6.
> > 
> > Or, if you prefer, simply reply (only to me, please :) to this email
> > specifying:
> > 
> > - name/surname
> > - affiliation
> > - short bio
> > - email address
> > - title
> > - abstract
> > 
> > Deadline for submitting topics/presentations is December 9, 2024.
> > Notifications for accepted topics/presentations will be sent out
> > December 16, 2024.
> > 
> > .:: ATTENDING
> > 
> > Attending the OSPM-summit is free of charge, but registration to the
> > event is mandatory. The event can allow a maximum of 50 people (so, be
> > sure to register early!).
> > 
> > Registrations open on December 16, 2024.
> > To register fill in the registration form available at
> > https://forms.gle/Yvk7aS79pvNR6hbv8.
> > 
> > While it is not strictly required to submit a topic/presentation,
> > registrations with a topic/presentation proposal will take precedence.
> > 
> > .:: VENUE
> > 
> > The conference will take place at Alte Fabrik [1], Daisendorfer Str. 4,
> > 88689 Uhldingen-Mühlhofen, Germany
> > 
> > The conference venue is located in a 2 minute walking distance [2] to
> > the Hotel Sternen [3] that has been pre-reserved for the participants.
> > Since it is a very rural area, we recommend booking this hotel as it is
> > close to the conference room. The price ranges per night incl. breakfast
> > between 85€ (Standard Single Room) up to 149€ (Junior Suite). There is
> > an availability of 37 rooms in the hotel. Another 13 rooms are
> > pre-reserved in the Hotel Kreuz which is also a 5min walking distance to
> > the conference location [4]. Cost is 75€ inkl. breakfast. Please choose
> > your hotel (and room) and arrange booking yourself. We recommend arrival
> > on March 17 and departure on March 21 due to the length of the trip.
> > 
> > Please use the code ‘LINUTRONIX’ when booking your hotel room. 
> > Deadline for hotel booking in Hotel Sternen is February 28, 2025.
> > Deadline for hotel booking in Hotel Kreuz is January 17, 2025.  
> > After these dates, cancellations are not free of charge anymore.
> > 
> > You can reach Uhldingen-Mühlhofen best from Zürich Airport [5] or
> > Friedrichshafen Airport [6]. From both airports there are train and/or
> > bus connections to Uhldingen-Mühlhofen which you can check here [7]. The
> > rides are quite long, so another possibility is to organize yourself in
> > groups and share a taxi/shuttle [8].
> > 
> > [1] https://www.fabrik-muehlhofen.de/
> > [2] https://maps.app.goo.gl/S6cnTgx1KJAGRkMr7
> > [3] https://www.steAlte Fabrik Mühlhofenrnen-muehlhofen.de/
> > [4] https://www.bodensee-hotel-kreuz.de/
> > [5] https://www.flughafen-zuerich.ch/de/passagiere/praktisches/parking-und-transport/zug-tram-und-bus
> > [6] https://www.bodensee-airport.eu/passagiere-besucher/anreise-parken-uebernachten/
> > [7] https://www.bahn.de/
> > [8] https://airporttaxi24.ch/?gad_source=1&gclid=EAIaIQobChMIo_y9l56iiQMVfp6DBx16NxPtEAAYAiAAEgJOO_D_BwE
> > 
> > .:: ORGANIZERS
> > 
> > Juri Lelli (Red Hat)
> > Frauke Jäger (Linutronix)
> > Tommaso Cucinotta (SSSA)
> > Lorenzo Pieralisi (Linaro)


