Return-Path: <linux-pci+bounces-41614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B0C6ED95
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E9973A39A6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226E35F8D0;
	Wed, 19 Nov 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DQJFkS9T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB343590D4
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557882; cv=none; b=ZrYNqYd57vT6U7vn7dIseTOSfycUPMNnORRWU2kLgRjCTJoQCATYE9kGoghLH7Qgx3cqp9WYr9QQGH5ikrYJ0d/hR9X3tjN0z0nok0uhikb4K/kdZscAd80XvB9lZwP6G4/fz3fr7k+rpkjdx9oKgbmpX9LMgt2SxZbT4W4Dclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557882; c=relaxed/simple;
	bh=sJLZgI9vl/ePXAMiM1HFoKkY761fjwT9P7fNtQPrjMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5hqt9yxKXrwE8qNZHS99MPimba+VzMML6GPP6I+nS/w6ATMeKWc+1ZjA2OmJXppelbOYHyqepr0RstfE0+S8Ay47HpgOHwnEnokZiIp9pdpmKCO/fqRzjUpqWg6B189cqqw6Mh7D9b0vAd1HD29Yw/VapK4tNHPmZVCpBs4eLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DQJFkS9T; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b73669bdcd2so938434466b.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 05:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763557878; x=1764162678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hIjgqXWXn3Sbfto+9OWapsp1QwhUBtS+kZIjBq+Tlw=;
        b=DQJFkS9TfIkIw04m01xXMLNrkosYb3FSrkUd1Mfnq3DmFPVYW5BQAF/kJ7qBH/fiSm
         pVnVkcfKZlPcHTsyEwqHQR67eAr7CHq57OGD53huuAi4hSCw/ct6edPOGR+fsY5nGz/N
         Yw1ooyFk/+rMnBQZngJcf6t2sX9N66HB8FZQS71x9KKl/6xkzHkV8uFKm2Iy/9fAm8Ag
         I22CiD+iqPZDy+W/I0Ox3Jki6uwZV0vfVWc6IvJTegJWTzKaS6FEi0EnBDDhgSnIfI+y
         k4OP4x8AdsPKrFrvmXhICnjEUtirKTXsrSbTk6Wz8fF+OXFqP7Hrg3yvNq2+bPjQ4kUM
         Gqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763557878; x=1764162678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hIjgqXWXn3Sbfto+9OWapsp1QwhUBtS+kZIjBq+Tlw=;
        b=iooYxyKy86LKC6hfmbe32/urOaUm3JmxXppGNXT5/VfC0DzOsDmkPhSOS1b6F9koW3
         jKeY3apxsLBV/roqxhbw2wLuv9+H1nfxV6MKCXaWlP70AF7vFBIvG6kAS4s9zsjr3rlF
         4Sr2hAl+xi8pyBT/U2I9snGH/DlSNZSAeYeLIi/6EyvCjA40AqRT1ZsINDT5w90nb+28
         08YHKUh1OtOJaJyuiJJtYOKq8T3T/OaS+mG/3CpcLmv4JVCE4P0exVU5l563GTBnbO1t
         HQDzs+9kKZbWvdTeSms2uHwzfgCVWqQA13oAlFrdHj8PwU+vdxNQWiisZqoE3acmuA9t
         2Gwg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Amy7vZBgnhMfBk6fn/lbT/TMUl+yzr/96HKjFLZI+XVhtnIm9Y0z4/TEEmvZ30vF4E9ufjNlH80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIpMWhgpTyx8pXuJLkIYllaCjezq+7OpAkH9PNMzGGmrS4v1/
	oR7QMYF3LB44O1j5+hTbWjvTCpY+PoAk6ImQuJYx1xkrlpmpNuVcP5YcstAgrXp66kE=
X-Gm-Gg: ASbGncv2ux1ZwctkLh9loVQTASPFZKfshinH2O8XmiwsoIqZ5eionOLYfjS/34hOhaP
	3Uiuuq/AJKCwpIg1yv0s51XixZgQtG4N6VpZNe6vnEf4erx2H/uMDQK92UI6yt+BuhLn6euyFyI
	Hwp5SX1V5gF+5WWo7hA/FRiLkfCTm3AjRSBfDhKE+Axj4T5SpYb87Gx+e80aissWseCtTu1w0wj
	OCtK0cM+mbJhJV+8DLUekL7lymE+B8lR2IdZD9MTX/F3i+1rbvgX1+QvIV/M8+C2cldRpq2yANd
	Nz9KlRRQ00ILSHbGjFgKGSwhxmMTpTjnqONURf0JcLd7kiiVVK6JW+s0vmMbG4onRn0BJg1mDp2
	VltB86PDQ+JqSHhr7hIzaA1UJHTpR6yN+lZJTed3u5PvV5pbjPa4IPjhMmymiM1i96VaqHTnwFi
	zeMMckr9ngH480jQ==
X-Google-Smtp-Source: AGHT+IHh/9HSY9QxYY7JWRlsHkQE77dEey/TQadLHho4kIFH9l0Cnuj5X98H1aD+vZkw9c2t87Tcgg==
X-Received: by 2002:a17:907:96a7:b0:b6d:50f7:a805 with SMTP id a640c23a62f3a-b7367c02586mr2099815666b.59.1763557878059;
        Wed, 19 Nov 2025 05:11:18 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3d8775sm15093392a12.5.2025.11.19.05.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:11:17 -0800 (PST)
Date: Wed, 19 Nov 2025 14:11:12 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/21] treewide: Introduce %ptS for struct timespec64
 and convert users
Message-ID: <aR3B8ECx9W6F0BV_@pathway.suse.cz>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>

On Thu 2025-11-13 15:32:14, Andy Shevchenko wrote:
> Here is the third part of the unification time printing in the kernel.
> This time for struct timespec64. The first patch brings a support
> into printf() implementation (test cases and documentation update
> included) followed by the treewide conversion of the current users.
> 
> Petr, we got like more than a half being Acked, I think if you are okay
> with this, the patches that have been tagged can be applied.
> 
> Note, not everything was compile-tested. Kunit test has been passed, though.

JFYI, the patchset has been committed into printk/linux.git,
branch for-6.19-vsprintf-timespec64.

Note, that I have:

   + fixed the 19th patch as proposed, see
     https://lore.kernel.org/all/aR2XAYWTEgMZu_Mx@pathway.suse.cz/

   + reviewed all patches but I triple checked 7th patch which
     did not have any ack yet. And I added my Reviewed-by tag
     there. ;-)

   + I tried build with allyesconfig. It succeeded. I am not 100%
     sure that it built all modified sources but...

Best Regards,
Petr

