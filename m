Return-Path: <linux-pci+bounces-36530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780FB8AE35
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F997C009C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A21FAC37;
	Fri, 19 Sep 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as6+PtlD"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2B264608
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305874; cv=none; b=rDLKcjStTDKiW+5dj97Ah/u8X+UWR+szRglE5gbEj8txNbooLRcC1cYymt9pP2kma6tqMm0U+4PRhpXXgUSeHnyo1sfSWgiad9XUrS+VrRKVZ3pkQT/9vZxmoYGSKa6Vr1HUZtQrGcRFqGLMG3DRYPHH7AQY76joj2N8zP9yHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305874; c=relaxed/simple;
	bh=UYQ/heBMSwesBf4ndeJdw8Tnd7iUiwyxPBtUng/3UNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaCB2Y1DeIBc7PqpSj44vw5GsizWehMZK3W6p3yRsD/6eR99uFRD/f6ekEuptZDsXlne/94SFCB3a7/n34+W++A7im5PLR7qccxfEHO4zjfD4YldQQFnaJIAui7oFhuGJQFwRwY1/YHFMdbiXS/6hFG60V3R1y1sbajI2RlAM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=as6+PtlD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758305871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tP8qgX24boDvqrfxOc41UrXAFnZAOnA7a7ICmrly80=;
	b=as6+PtlDF47Er5GWz7tY9mCB2nsp160VZymaI0BxxlLmEBaCn65cc/8kHw1SUR4V7Unahu
	c+8gRW1NhVzP8/3AsEfSdB2IHBIeRKPaKrdEbVOylqiZDV2RdDWi/cIqieMVRIbcBr7iic
	MTPo6iI9Mnsx23KIdOZ6JOKI3BNePRI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-9Gdpz9NuNOiTiceHlWrKIA-1; Fri, 19 Sep 2025 14:17:44 -0400
X-MC-Unique: 9Gdpz9NuNOiTiceHlWrKIA-1
X-Mimecast-MFC-AGG-ID: 9Gdpz9NuNOiTiceHlWrKIA_1758305863
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-40b911746f0so5637355ab.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 11:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305863; x=1758910663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tP8qgX24boDvqrfxOc41UrXAFnZAOnA7a7ICmrly80=;
        b=G1vfCrcQsRmLVtoAUKQbYPKe3WVRDyqHHpCuGZr729AbD44erTpNbKG/FY90OvX0TT
         A62Bw7V6DA3TseJIQTW9f5trNt2gZBC89nzVFPs4F50sBiJn4BcLt5lNNvyim/mxYYID
         o5+Ojt20tDiSHyp+kDEJHi8fBacJMQvR+iUugh5ecoCjN+K246i63zZENOxAufDBOxM7
         6VBItr4RSAsOefvs8NgTrrJLbbD71iBY8spFUP2lTxpty6ilafEstkl5OO8LHyxN4qAk
         OBcFSBfijUmL8p8Nc9RU3Pyy3j9Uu9tThumeMGBxKS7KjfGc3WaEs+RmJ45l+tjiHEIz
         WcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXch2Ab0ybBHBEDXqps5F/1vL83LZkXY6Wuj/zLrU4WNSSrGNg3Mnlx63MGShBCMCqv7wPJ2QVCPwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66iFcAXZxgSLr5JMBT3wzgiPojl/L8IFpTUsqMonOsRHLKT/A
	nlMj1r9b3ETdZB9YUCS/jBTOTPnaNemrEGTk6GD02nzhOVJpAxAXUR3rgicKA77kfW3Oi956v3K
	ZW+KqRHT7izolQ1nGmyD/Xvel+TLc32Hbze8cjjNsB5XrUXYaGLVj48Qt8hEpXA==
X-Gm-Gg: ASbGncvlY792JVuYNyVphaTOrW89zG4zrV8JX0rRKbDr1+yxplTG0Oowtp41HmGCRiw
	EtoNWdCkk6ksv8i3ES3bIZj2xqkJcuRBQ2OzxwAieTjC/MGGvQR2kgCc1GRoRLSIHjorCjlYoVm
	ZZWtphRgu2pci85PTpD5JWSLrJz9yXUmiLXwm+pNbyZ1YvNHcdCLxp3ONckUprA67hNw2U1vOMn
	LldyKY3vRXLJZio/50mP96TLv5cgrpFrEqPu6ZaNp8Y+RrMktDipnVNo6gqgYcnl8UdndNZE79H
	HUplDd1Bz9bt8evd13j+mqkJfdonYgSrY5WwNX2v/GE=
X-Received: by 2002:a05:6e02:1d9d:b0:424:69b:e8d0 with SMTP id e9e14a558f8ab-4248190395emr19310645ab.1.1758305863182;
        Fri, 19 Sep 2025 11:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb10MnB7zhkH1dVW9AEzJVk+z8ybEB8AlSck6uXI8Tp5xc6aeeZCL649awhtncJC1hXa8bVg==
X-Received: by 2002:a05:6e02:1d9d:b0:424:69b:e8d0 with SMTP id e9e14a558f8ab-4248190395emr19310505ab.1.1758305862772;
        Fri, 19 Sep 2025 11:17:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm24280945ab.22.2025.09.19.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:17:42 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:17:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3 01/10] PCI: Avoid saving error values for config
 space
Message-ID: <20250919121739.53f79518.alex.williamson@redhat.com>
In-Reply-To: <d6655c44-ca97-4527-8788-94be2644c049@linux.ibm.com>
References: <20250916180958.GA1797871@bhelgaas>
	<d6655c44-ca97-4527-8788-94be2644c049@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 13:00:30 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 9/16/2025 11:09 AM, Bjorn Helgaas wrote:
> > On Thu, Sep 11, 2025 at 11:32:58AM -0700, Farhan Ali wrote:  
> >> The current reset process saves the device's config space state before
> >> reset and restores it afterward. However, when a device is in an error
> >> state before reset, config space reads may return error values instead of
> >> valid data. This results in saving corrupted values that get written back
> >> to the device during state restoration.
> >>
> >> Avoid saving the state of the config space when the device is in error.
> >> While restoring we only restorei the state that can be restored through
> >> kernel data such as BARs or doesn't depend on the saved state.
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   drivers/pci/pci.c      | 29 ++++++++++++++++++++++++++---
> >>   drivers/pci/pcie/aer.c |  5 +++++
> >>   drivers/pci/pcie/dpc.c |  5 +++++
> >>   drivers/pci/pcie/ptm.c |  5 +++++
> >>   drivers/pci/tph.c      |  5 +++++
> >>   drivers/pci/vc.c       |  5 +++++
> >>   6 files changed, 51 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index b0f4d98036cd..4b67d22faf0a 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -1720,6 +1720,11 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
> >>   	struct pci_cap_saved_state *save_state;
> >>   	u16 *cap;
> >>   
> >> +	if (!dev->state_saved) {
> >> +		pci_warn(dev, "Not restoring pcie state, no saved state");
> >> +		return;  
> Hi Bjorn
> 
> Thanks for taking a look.
> 
> > Seems like a lot of messages.  If we want to warn about this, why
> > don't we do it once in pci_restore_state()?  
> 
> I thought providing messages about which state is not restored would be 
> better and meaningful as we try to restore some of the state. But if the 
> preference is to just have a single warn message in pci_restore_state 
> then I can update it. (would also like to hear if Alex has any 
> objections to that)

I thought it got a bit verbose as well.

> > I guess you're making some judgment about what things can be restored
> > even when !dev->state_saved.  That seems kind of hard to maintain in
> > the future as other capabilities are added.
> >
> > Also seems sort of questionable if we restore partial state and keep
> > using the device as if all is well.  Won't the device be in some kind
> > of inconsistent, unpredictable state then?

To an extent that's always true.  Reset is a lossy process, we're
intentionally throwing away the internal state of the device and
attempting to restore the architected config space as best as we can.
It's hard to guarantee it's complete though.

In this case we're largely just trying to determine whether the
pre-reset config space is already broken, which would mean that some
forms of reset are unavailable and our restore data is bogus.  In
addition to the s390x specific scenario resolved here, I hope this
might eliminate some of the "device stuck in D3" or "device stuck with
pending transaction" errors we currently see trying to do PM or FLR
resets on broken devices.  Failing to actually reset the device in any
way, then trying to write back -1 for restore data is what we'd see
today, which also isn't what we intend.

It probably doesn't make sense to note the specific capabilities that
aren't being restored.  Probably a single pci_warn indicating the
device config space is inaccessible prior to reset and will only be
partially restored is probably sufficient.  Thanks,

Alex


