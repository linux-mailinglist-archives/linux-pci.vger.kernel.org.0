Return-Path: <linux-pci+bounces-36196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA64B584CE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 20:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8544C24DE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60A614B953;
	Mon, 15 Sep 2025 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQh6+HDj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E327A92A
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961701; cv=none; b=I3mZwK0pDPv23kZBAyR7eDBZObjAw3R7R46RcPEvLBk7mjNwB3yU0WpH4flTDDpPfMBJKNRgb2nEx5M6OFSFmASLsMqk6yhseS38A9tY3nyu4/yY2uIcaeOPh1NZ400eNeC2WXWzXHo0vVGT0Qhk4VCK2AwDVfBVZ9N7PvnqWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961701; c=relaxed/simple;
	bh=oPccXBrUqI8/MvE8k9QrGmavp+NZUnAV7TpP14XIh1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8qlAO5SWukn5e1ycucqn4v/WJY0X1i/Tv4Rpeq+gc19Ve4JDZz/dYSBqTDX7Wg0L6BkIP77OYy1yGhPehggWsQQ3mwOSIGI48YSDZ4eXyRCWjx0KcTdhPDmcH9zZb7JGzYx9LLqKASDUi4xuP7aOyS8cdHgg3ENAS8lN3H9ZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RQh6+HDj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77256e75eacso3767827b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757961699; x=1758566499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvNrOR4ellqZqvuE2ABZzj31gMsgVuW0rC+wrpkvP4k=;
        b=RQh6+HDjWB8BIpncYrlpe38iW5hNnBqKNpT/1uDM85K/0//qGxzY3Ck5WLFTqOCUGO
         MXAKljODka1QYTxPJV2v6OWBdyvXryogLe2JPPvRr44yB5bqVfBtY9qQ0IQ+cyMJ6xT6
         rEqgVVmjJq9SgXkW2XcEaYLZ4c7zfckcqqnus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961699; x=1758566499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvNrOR4ellqZqvuE2ABZzj31gMsgVuW0rC+wrpkvP4k=;
        b=EN62/cn6/0hIc+eprUg5WHxKArCHpSuB8yXxL66K7Svn7trINuHO1TJAACPQFWJDrO
         7+1C1PixVLcx0YlWWi3fHNV2LjH12i9UXUBtHNZ9/7GkpxD+M9RDBXd6RgNvaHcitN3i
         SAWpBo1EU/Y3CCTv2Q9fnsWhf0vlZts65C+0IjyYIFmv8rArVCWEeDTbt4i+3kN5JPlA
         Z4lM9gAf3GMvEg+oc7rdBaMD88pVYWIFKPZ2bQFUOv2H475+NJOcvRyj9vDzI4M3KHK/
         IrSXOkV4GYVJixWUi06BAqTIq0CTze1sv31vEP9sZXvfCAU73kGF9uV6r8CJXUvG+SuS
         Afug==
X-Forwarded-Encrypted: i=1; AJvYcCWfds/KAVMSiYEEwOglseaUUl2icGhI5f+8YpLRQCYLifKololxX54UVubbHCNhQ0o/f+rBCNgmK9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAihDpW+QDdmNcDF0QAPUDDUE1V17ijc/w/pRjKGlrqMiVKrGb
	SWTcy6Iuycx+KdrhtCvskOkbK1paASTysCyAv8qFM4RyyEc8PyLFjLKnO6Aqg7GLoA==
X-Gm-Gg: ASbGncu7yxw+WkIHNfv8rST3GgZYS1GgZrDX52zdefMWuu3tTwOI5DHw9Euo/tP1XGD
	29OuLEe0W9bOR10kyiGYzuci1thNhy5fvHHqhSxOL2Ng4ncznfLsefy7QmHfORMfvrTmvfiwDkb
	XDyXE0uD580FBt/gTUK84Ce/BZKuYhSczT6fPD+PFNuMSNIlxRMvFVjjOfnpFLOT3DkVzkagNGP
	FP3ceXm01u/UnoASD7iTsmYTgLwz8jtG9cZn3Vivc6FsOTK7dob4qBuIp8LjMj8FuyIU9fqsWVL
	8mfmhOTTzS4ZqK1ju1qpIC6QbnulfSC1gAF+PAP3ezki7dDb5ivGE2PO2Mj/8rSfCzmLvIPsqi+
	9ZgOU2iZrAuBUD03bNhaLT1TryARYsXV16ldOtYjqNPGpPh8sSssAyfmoLzb5/94vIH/HF+w=
X-Google-Smtp-Source: AGHT+IGlRm1d0pxmlp5QnmWl5T2hIZtYHRH5ZefBsxntjPmY3kpOuBh7Py9dWQ+bly9aiTvcXCvOzw==
X-Received: by 2002:a05:6a00:9289:b0:772:4759:e433 with SMTP id d2e1a72fcca58-7761209bdeemr15688778b3a.2.1757961699464;
        Mon, 15 Sep 2025 11:41:39 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:fd49:49b1:16e7:2c97])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b33c45sm13983580b3a.71.2025.09.15.11.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:41:38 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:41:37 -0700
From: Brian Norris <briannorris@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aMhd4REssOE-AlYw@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMgZJgU7p57KC0DL@infradead.org>

Hi Christoph,

On Mon, Sep 15, 2025 at 06:48:22AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 12, 2025 at 03:59:31PM -0700, Brian Norris wrote:
> > This series primarily adds support for DECLARE_PCI_FIXUP_*() in modules.
> > There are a few drivers that already use this, and so they are
> > presumably broken when built as modules.
> 
> That's a reall bad idea, because it allows random code to insert quirks
> not even bound to the hardware they support.

I see fixups in controller drivers here:

drivers/pci/controller/dwc/pci-imx6.c
drivers/pci/controller/dwc/pci-keystone.c
drivers/pci/controller/dwc/pcie-qcom.c
drivers/pci/controller/pci-loongson.c
drivers/pci/controller/pci-tegra.c
drivers/pci/controller/pcie-iproc-bcma.c
drivers/pci/controller/pcie-iproc.c

Are any of those somehow wrong?

And if they are not wrong, then is this a good reason to disallow making
these drivers modular? (Yes, few of them are currently modular; but I
don't see why that *must* be the case.)

I agree, as with many kernel features, there are plenty of ways to use
them incorrectly. But I'm just trying to patch over one rough edge about
how to use them incorrectly, and I don't really see why it's such a bad
idea.

> So no, modules should not allow quirks, but the kernel should probably
> be nice enough to fail compilation when someone is attemping that
> instead of silently ignoring the quirks.

Sure, if consensus says we should not support this, I'd definitely like
to make this failure mode more obvious -- likely a build error.

Thanks for your thoughts,
Brian

