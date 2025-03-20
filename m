Return-Path: <linux-pci+bounces-24211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE9A6A154
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C003B7BBC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9251EE02A;
	Thu, 20 Mar 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YU6eHda"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2D20D519
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459289; cv=none; b=ZFbPKloXLXgwtCgaN8KbqaSbRREDHRWctCtdMu9/+M/o5jJ/wx7HdJKcTXmWGIC5HRvRJP+4NOr7pi89lHej/JcbnAxr7yvs19PT/RxfPEpwS4TB0UlQm3fMBvTtD0fIEQIMJ6iB7NP0++fYa2blWWjxHe4C2rOdi3DkUeYjUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459289; c=relaxed/simple;
	bh=sGI+uWbgnqipcG4NA4H5+paDF7Oa6IbiouQydIO81bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ox94SthpnyNBBYYuT7aWX5911uA8oQe4jOMM+CpoFFpag9pKdRyF79k9pMgTi4B993XN6QOTpr+AFbm3zeFleBjoy2eprNSUm9EALrIHSn1V4Yrn+7IubfQazuttR9kl7vz4hVcVizGNqnruaTCPaHVOIhswZqmnVGnHWs4T8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YU6eHda; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso95296766b.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459285; x=1743064085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dZhptpFM9pcvAFpzaAi9eF3a5isjwTP0H7+ugtQyaw=;
        b=0YU6eHdalah9x7TxgmyCK2rwWkuStnZySP46xIKLQlc4SKOwUBdU7OGyTU5oK+bRRJ
         LIRASapqmPvm9NEbH2KA8XIkYqJUw22O771J3XfmsyhD/w9i/AmeHun4XyBT01ow9qdF
         86VxUz13hKwms3nPo9dJfWAec7A+ix6dYn+W3neJi0C1Z1QerVdtUI1SQ8Ee7UYQ5M6E
         tB7W+C3e1tInTBF1xt1bcD82IKPbqjuuk7diBXHJ+9EAu+Vt7ukyl2U/uvm5mqJXUTym
         vGdorPtgSPaMQpj/ooiJQ/NEvu3oNcpM+YfbQfsHrkO2gLgcyJTNJ4aIjLv7iqFDukiy
         5tCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459285; x=1743064085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dZhptpFM9pcvAFpzaAi9eF3a5isjwTP0H7+ugtQyaw=;
        b=bicEZXYDWo2c2ilUf/re0SQgyOiX0aDwfv/Pw84DS57pq9xWTsKhyOEhxtMsGSi+mJ
         /r86Y+8diOO1uUrWau59Y+JROs2AcDXi0yrNN6qKcCbYuAMy+q2lpJeKur8roJNUHRkN
         Hb5zoKj0H/EvZYGKe+be0/rGQth8sq8UcU5oLS09OFZC6xWm5Rt3vKo7yS++cJeIXbYK
         +0fYQ/9xpbovy0A2klYPKQKaf2+MCvlurbK4DJmxGtYdSY1ojsFCuI2K9RHz8Rf2UoIb
         P7GsQWGTxMY09ewV25QodNGQ9BILuR7kX1aHWxgQjPD0shKcl0hFDruY+qdALNN1x9NO
         y3+g==
X-Forwarded-Encrypted: i=1; AJvYcCWf8uRJwu2cYpatf6Lj2k1SUWimiJiCoyqa/qU3iEulbeJomuTzyzJERI4VFhmgk+KevggL8p9Hi80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57TG9orZIPJdONCHvC8dhWoC0gS4gG+BtOfeEDGZQoXavWDf4
	FfOM4H8/arIE7soGfM1c07qKXcK+O/pe6nWVXpxvO6CEvggW5Yg/pY6JFX3Y64N0z6UdP36b/I0
	AbxN5E0uc0LnMi6i6+H/FG4ViN0YyyPCj9tt/
X-Gm-Gg: ASbGncup3BaXIaf8BL0vpcCTRrYhi8LMCLL1/5xyaBRIxa8VWWctIvKeAuyGXuPflF4
	325GEuVvwyC7hoIjZwWO3SydKXDggJ8kY5jyjJ9ASXSHOnev+cidJMSomtUPMkkjy6bA56V5m0d
	1dZIePmi5PJogFWjJ+S5AHHLc=
X-Google-Smtp-Source: AGHT+IEavyBJ1wB13gyE6E6KZYuJNNnY07XMWPxANS8zoKBYj/6P6p9B2fBnwyfeUJloF4ga02paVdXrPwObwoYgX/M=
X-Received: by 2002:a17:906:c142:b0:ac2:87b0:e4a5 with SMTP id
 a640c23a62f3a-ac3cdf7936emr256901666b.2.1742459284837; Thu, 20 Mar 2025
 01:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319084050.366718-4-pandoh@google.com> <20250319181948.GA1050371@bhelgaas>
In-Reply-To: <20250319181948.GA1050371@bhelgaas>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 01:27:52 -0700
X-Gm-Features: AQ5f1JrBNIsYP6sTVVNsUa3Kb3VowmngExVBg-DCFp-wV7dbVJ1G1rnOjJqm2QQ
Message-ID: <CAMC_AXW85x_LRT5UTD0C_VvK8WTG6kbfvp5k_7RjnLzGM3Bg-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] PCI/AER: Move AER stat collection out of __aer_print_error()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 11:19=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> This moves pci_dev_aer_stats_incr() from __aer_print_error() to
>
>   - pci_print_aer(), used by CXL via cxl_handle_rdport_errors() and
>     GHES via aer_recover_queue() and aer_recover_work_func()
>
>   - aer_process_err_devices(), used by native AER handling via
>     aer_irq(), aer_isr(), aer_isr_one_error(), and
>
>   - dpc_process_error(), used by native DPC handling via dpc_handler()
>     and by ACPI EDR Notify events via edr_handle_event()
>
> And the reason for this is ...?
>
> Maybe just to separate stats from printing, which does seem reasonable
> to me, although pci_print_aer() is still primarily a printing
> function, albeit also an external interface.

Separating stats from internal print functions allows us to:
- easily add ratelimits to logs while having stats unaffected
- simplify control flow as stats collection is no longer buried

pci_print_aer() is the odd one out, but that should be temporary as
Karolina's log
consolidation patch[1] should allow pci_dev_aer_stats_incr() to be pulled o=
ut of
print functions and called after the newly created populate_aer_err_info().

> In any event, I would like to include the motivation.

Ack. Added in v4.

[1] https://lore.kernel.org/linux-pci/8bcb8c9a7b38ce3bdaca5a64fe76f08b0b337=
511.1742202797.git.karolina.stolarek@oracle.com/

Thanks,
Jon

