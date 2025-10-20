Return-Path: <linux-pci+bounces-38808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB10BF3C1D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 23:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B0B405A86
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C9334693;
	Mon, 20 Oct 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pH1F9PaG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462630506E
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995794; cv=none; b=L1TKJmlZcZck5RKyRIMOdbdstN1SL2Ru/SShVdKN9wfpp0dQZknFKhTVeH//gZsvyX35SkgiwC3X6jeYOF+vwZW7xZtvZJlpcLiHnzOluYY4R6chwOQl3x68EPEWkIiNV+7rmQu5uSPNlF1xw0OIRYI5/In6MDRTZaqqJ5Ow8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995794; c=relaxed/simple;
	bh=PqlFilZVmSbZKJLHpAkGDW0igOyGGkLNA6FRjPXGD80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFTv9cw4hT3FbDgIM2rBuR7NVlUKEjf4UBJQ/G8TvoD9cciUpeeA4xJ79qdKHqnrAPnJmsfVigLSpBlCtMdC/1t4CVbnUTunIlzONQwy2hvpbOqoTGj8vBpnZnXRUV13cwIuh9Kcn2gq+smoYewepBOgLt6UMrZuSPVntItRA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pH1F9PaG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b57bffc0248so3381275a12.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760995792; x=1761600592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26ASe6SsfcfwXN+JG/2GTGw7BHHgM1XlqQIlC1K/NBc=;
        b=pH1F9PaG83SuIUzI/Hf+agxVn8OYe5JWQWyaYHTdL8MYf9u7HGfxdfR4ULJ/pZqx2L
         yni2K5bxNwDJx0fGyhLsrrMTHrT0lrtlnnD9fKkcqex+Oy2jVLXwxvvH1VveuEUrDmMB
         +XN+vcHMOT2SMw7MqspKHuMUyxKMC9LE2mYTL/5pZiHX5rOrpoAbdV5km9iuzvkPvSl7
         1+SdOvcY3sG6yW79L2YCvevHQvjxSTauhLTADGVK+lRuFnHTYUoCDwET19WsiUhXDVdh
         itY55k9xItqdcTJhFUoRSIIPDiYxOf3mogT6SoqNj2jkqOzfjneg2p/x+oMQ8jFtJqrq
         8JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995792; x=1761600592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26ASe6SsfcfwXN+JG/2GTGw7BHHgM1XlqQIlC1K/NBc=;
        b=f6QQwX5AM+REYWsmq5PaDck3tlajKzgudCpuCSCl8YymOiyo5lw5EOIMgndwaBKdZg
         4djPbxuGJPHX+2Xvtz4vKEfTlkUSJfYWGIow+YLUCHHBlBYC9gohRL+zkSUx/uoRObes
         WKRBluXb1L2K4XgIuvuGA7Gmi6ltKdnGS9rOA4DwVn9QuvdiZ6eV+8nGfVHpDfQpPI9E
         yv+fFc/8Lm8drUzDppt0HxBSlf62my+Re9rRDhPjgrDkUYoJZVHOM9FcrZuP4YWJDmx+
         wCXpVZkIbJwhFAcZQ5UnxLWwgRbS944S1XiILafCfTpFUQ5akykGNv57x72hrX8PTkbr
         XBVw==
X-Forwarded-Encrypted: i=1; AJvYcCV1TihruQJmA2nutierN56FmLoJwxGq5NnBRT9jvIG0RWd49RVhZZi1MHhNgCn2a5AINdkDop8IpDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVhkiVe0bHRQENwTwpUhJucJkFj932fvjSZc0ipsvb9tsS8/X
	Yl/2t0tS5LOO2E6TGJ2l2nxbhYe+cZ94tC5MpCOOOSh/Pal/Yq/ju6UnqW+IxJWUBw==
X-Gm-Gg: ASbGncvGQYBaXbd/p3571Y7PesBTpyonyQbj6JPvOk3EBf8FDndgu5dqiRQFPyx4BJ+
	Tc5TslyFRWfCuYNPlsyeTOMxK+P8I+r4yie48dMjq4S1E0ePo1phwejb5McEp5WA0PqwVQhnLkp
	0eOonbGC9viXg+kgG7hizQMqfl2ZeurrarmM9RysIIlckrXLCKj/FYNy0QaxK8Yxaafia8IZXkZ
	Rpw4jHiPxhKZaNArsIDwE4gknVzMk+HfYAQRRUVVcwj6OMWfiIadx63fK5YrLec5kYhEey4VikK
	ei4qtpkr7jXIy58v1kpibIeLOVHZKiXbF6HJ/Q0WQSrBMQTF3/k4IQWndFNT/CtOZOw/suMBtfA
	LbGr2ECfderjLpeMxVx5o/I+AZgDS9aQkFiUR+2SBkojSlKeSkck8XAXULUjD4LEvklQThZEPrO
	oXBkfEnkwgokB3iboMTL48/M41q/+b9D/r2hyujsh+0JdHYg==
X-Google-Smtp-Source: AGHT+IGk4YTNxvDRPlGdzR4t9GlLZJuciLlt+LaOjUUn8d6Qy58ILE26bgum5kvXRpVHjALaky9Cew==
X-Received: by 2002:a17:902:ecc6:b0:249:71f5:4e5a with SMTP id d9443c01a7336-290c76f8182mr169199055ad.26.1760995792362;
        Mon, 20 Oct 2025 14:29:52 -0700 (PDT)
Received: from google.com (96.75.168.34.bc.googleusercontent.com. [34.168.75.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193dfsm88852855ad.105.2025.10.20.14.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:29:51 -0700 (PDT)
Date: Mon, 20 Oct 2025 21:29:47 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 12/21] vfio/pci: Skip clearing bus master on live
 update restored device
Message-ID: <aPapy8nuqO3EETQB@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-13-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-13-vipinsh@google.com>

On 2025-10-17 05:07 PM, Vipin Sharma wrote:

> @@ -167,6 +173,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
>  	 */
>  	filep->f_mapping = device->inode->i_mapping;
>  	*file = filep;
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	guard(mutex)(&device->dev_set->lock);
> +	vdev->liveupdate_restore = ser;

FYI, this causes a build failure for me:

drivers/vfio/pci/vfio_pci_liveupdate.c:381:3: error: cannot jump from this goto statement to its label
  381 |                 goto err_get_registration;
      |                 ^
drivers/vfio/pci/vfio_pci_liveupdate.c:394:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
  394 |         guard(mutex)(&device->dev_set->lock);
      |         ^

It seems you cannot jump past a guard(). Replacing the guard with
lock/unlock fixes it, and so does putting the guard into its own inner
statement.

