Return-Path: <linux-pci+bounces-14958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 843159A9330
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 00:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C621C229B2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 22:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101CE1FDF85;
	Mon, 21 Oct 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY1PVxzQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06F1FDF88;
	Mon, 21 Oct 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549195; cv=none; b=HAATYwMps1/4imZCwsd5Nese+cJ8zKbOZP8UPt9dDODoefDCILqUrgriS08b1F2qFoc/Q/Dp1TO4jjScXPLKq573/RrWUaLAis195hWwxPts6PhLKolr0EQUFXeAaqsZEIAdU+rrP4qiIy3UUAj4CMQdguOvLUs5k8ohYVzygVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549195; c=relaxed/simple;
	bh=diKNMK3Qe9TVzYTct8pJQa3ZgQbJBEctfTGOhA6eNjE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXgonsOy4pBVGEuFPzyS2u5IHaUT3xPE4a876XTs2g+kz9MrBwH0gpvmCLXQriGY/ubYLgOaVhrGEkJzO/wK8XiyC8IP7dfdwEgsC4pqcEgAJ4HZ8GnrqKVjU9DJNCh4vfDF+5mNe9esKV/wRUAIBMmup9bskBe3d2AAmLsT2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GY1PVxzQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so2050302276.3;
        Mon, 21 Oct 2024 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729549192; x=1730153992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3fHFzTzwtnaiiSBzJZZQe8XpRwnesGuRxl9fLAMU1c=;
        b=GY1PVxzQaTzMGsWDjURNlVRKN9Oa4LuCh1T2uLUhD/hDH6UCj0Y21bQ0wsT8ol3z5X
         9RqbsTgbZ5Rm/Rnj+f3S2v5IAAICbcTLVr8Q+Q3sgjXz93KF1usdeJLP0Yd97O5SNLGH
         9oFwSU3/xPXRVbKj6J6aoow2sFbeN71L4TTulGnBwi0ku+AIQ5/7oA0vN+pnqX2vysH4
         fnAMFLr1eUNP+ObMcT31AIyAid/MJR7e3u7VU2G8FvL4vRnkMMVwJvLOUyb3yn/69F6u
         hh7/h184/FQ1cgYbu8jrEkX1oSn7uEnzakoVR28K/cEorOVkf0gQGh243jDZQfFbaBVX
         T80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549192; x=1730153992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3fHFzTzwtnaiiSBzJZZQe8XpRwnesGuRxl9fLAMU1c=;
        b=GWQxKiXVmWocuYSQ++ID0qB6JecJttsfMa7l4hQYzIyXzQd6tSXqVMeyNv2KkoHOeF
         NjGLVFWI/AS4gUxVFlPMmozngravKDu6F8Jpg/9mlVB67CnXt5DIrTIO90eNOB0MHIEA
         CQqFsClb1+ilIjczNGF3dKIvqv0jGJlwtbe4tRCvpkIihmrwPW5ee02/so/Qe3E28Ff6
         KrD/abWqCFUkB7AJ3GvobS5XOxsC+PBYK1SGSwI3Sqpf9p2TJA6JRZv/aexjTjJhEIZ4
         FqzdavUCoFdkakPCAckz7oAdnVTU83918N6OH9RADl5eEm/mXyvp5k0XpRkvIbkMB4y9
         Yf7A==
X-Forwarded-Encrypted: i=1; AJvYcCUdWK4ECzit10xWzeKHYoOzeWJ+Kbz+UaE1ffDWnjqtZgPkIuc1PBSBOPpwWRCDU96rR3zTkaK4mCE=@vger.kernel.org, AJvYcCWlx1oHq6br2CJrPTpXycC2xRHmKZb4ZGuMikCxXZAXINJkrEMNbCc9Ze03YXprsOPSNHQa2hAuIOOgMjYl@vger.kernel.org, AJvYcCWmMVwkILKrccXxiHXybuLdytJ2c5HmjoOH4b7plqxJeZJhyZHgGJrBo4F58S6Itq83xSZtxVS6umSe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/FR8IfPGClK3SLrIGWUBDX3HllfhFMjMbQpYwyUmtdBzgUCy
	QKfcyopdIcsKCI7LTkomT2VjZoW6S7TYROafdS33belpF5CcrIA+
X-Google-Smtp-Source: AGHT+IE6DCryAMRTcQ/uYaS+w9dgwclJfmstPIXQ7cQMdqYtzykFctUoamtl2khAknAXDVOeKjGbbQ==
X-Received: by 2002:a05:690c:6210:b0:6dd:d5b7:f35d with SMTP id 00721157ae682-6e7d82b1bafmr6517197b3.30.1729549192267;
        Mon, 21 Oct 2024 15:19:52 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb435sm8458227b3.91.2024.10.21.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 15:19:51 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 21 Oct 2024 15:19:38 -0700
To: "Bowman, Terry" <kibowman@amd.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, Terry Bowman <terry.bowman@amd.com>,
	ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Message-ID: <ZxbTepcs8eJqckFN@fan>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <ZxE8jn9M7twa4v2u@fan>
 <8c34b676-e71a-42e8-96fe-485ffeaa8328@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c34b676-e71a-42e8-96fe-485ffeaa8328@amd.com>

On Thu, Oct 17, 2024 at 12:27:04PM -0500, Bowman, Terry wrote:
> Hi Fan,
> 
> On 10/17/2024 11:34 AM, Fan Ni wrote:
> > On Tue, Oct 08, 2024 at 05:16:42PM -0500, Terry Bowman wrote:
> > > This is a continuation of the CXL port error handling RFC from earlier.[1]
> > > The RFC resulted in the decision to add CXL PCIe port error handling to
> > > the existing RCH downstream port handling. This patchset adds the CXL PCIe
> > > port handling and logging.
> > > 
> > > The first 7 patches update the existing AER service driver to support CXL
> > > PCIe port protocol error handling and reporting. This includes AER service
> > > driver changes for adding correctable and uncorrectable error support, CXL
> > > specific recovery handling, and addition of CXL driver callback handlers.
> > > 
> > > The following 8 patches address CXL driver support for CXL PCIe port
> > > protocol errors. This includes the following changes to the CXL drivers:
> > > mapping CXL port and downstream port RAS registers, interface updates for
> > > common RCH and VH, adding port specific error handlers, and protocol error
> > > logging.
> > > 
> > > [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554
> > > -1-terry.bowman@amd.com/
> > > 
> > > Testing:
> > > 
> > > Below are test results for this patchset. This is using Qemu with a root
> > > port (0c:00.0), upstream switch port (0d:00.0),and downstream switch port
> > > (0e:00.0).
> > > 
> > > This was tested using aer-inject updated to support CE and UCE internal
> > > error injection. CXL RAS was set using a test patch (not upstreamed).
> > 
> > Hi Terry,
> > Can you share the aer-inject repo for the testing or the test patch?

Hi Terry,

Could you tell me which code base you use for this patch set?
I hit a lot of issues when trying to apply it on top of "fixes" or
"next" branches.

Fan

> > 
> > Fan
> 
> Sure, but, its easiest to attach the patch here.
> 
> Origin was https://github.com/jderrick/aer-inject.git
> Base is 81701cbb30e35a1a76c3876f55692f91bdb9751b
> 
> Regards,
> Terry

> From ca9277866b506723f46f3acd7b264ffa80c37276 Mon Sep 17 00:00:00 2001
> From: Terry Bowman <terry.bowman@amd.com>
> Date: Thu, 17 Oct 2024 12:12:58 -0500
> Subject: [PATCH] aer-inject: Add internal error injection
> 
> Add corrected (CE) and uncorrected (UCE) AER internal error injection
> support.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  aer.h   | 2 ++
>  aer.lex | 2 ++
>  aer.y   | 8 ++++----
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/aer.h b/aer.h
> index a0ad152..e55a731 100644
> --- a/aer.h
> +++ b/aer.h
> @@ -30,11 +30,13 @@ struct aer_error_inj
>  #define  PCI_ERR_UNC_MALF_TLP	0x00040000	/* Malformed TLP */
>  #define  PCI_ERR_UNC_ECRC	0x00080000	/* ECRC Error Status */
>  #define  PCI_ERR_UNC_UNSUP	0x00100000	/* Unsupported Request */
> +#define  PCI_ERR_UNC_INTERNAL   0x00400000      /* Internal error */
>  #define  PCI_ERR_COR_RCVR	0x00000001	/* Receiver Error Status */
>  #define  PCI_ERR_COR_BAD_TLP	0x00000040	/* Bad TLP Status */
>  #define  PCI_ERR_COR_BAD_DLLP	0x00000080	/* Bad DLLP Status */
>  #define  PCI_ERR_COR_REP_ROLL	0x00000100	/* REPLAY_NUM Rollover */
>  #define  PCI_ERR_COR_REP_TIMER	0x00001000	/* Replay Timer Timeout */
> +#define  PCI_ERR_COR_CINTERNAL	0x00004000	/* Internal error */
>  
>  extern void init_aer(struct aer_error_inj *err);
>  extern void submit_aer(struct aer_error_inj *err);
> diff --git a/aer.lex b/aer.lex
> index 6121e4e..4fadd0e 100644
> --- a/aer.lex
> +++ b/aer.lex
> @@ -82,11 +82,13 @@ static struct key {
>  	KEYVAL(MALF_TLP, PCI_ERR_UNC_MALF_TLP),
>  	KEYVAL(ECRC, PCI_ERR_UNC_ECRC),
>  	KEYVAL(UNSUP, PCI_ERR_UNC_UNSUP),
> +	KEYVAL(INTERNAL, PCI_ERR_UNC_INTERNAL),
>  	KEYVAL(RCVR, PCI_ERR_COR_RCVR),
>  	KEYVAL(BAD_TLP, PCI_ERR_COR_BAD_TLP),
>  	KEYVAL(BAD_DLLP, PCI_ERR_COR_BAD_DLLP),
>  	KEYVAL(REP_ROLL, PCI_ERR_COR_REP_ROLL),
>  	KEYVAL(REP_TIMER, PCI_ERR_COR_REP_TIMER),
> +	KEYVAL(CINTERNAL, PCI_ERR_COR_CINTERNAL),
>  };
>  
>  static int cmp_key(const void *av, const void *bv)
> diff --git a/aer.y b/aer.y
> index e5ecc7d..500dc97 100644
> --- a/aer.y
> +++ b/aer.y
> @@ -34,8 +34,8 @@ static void init(void);
>  
>  %token AER DOMAIN BUS DEV FN PCI_ID UNCOR_STATUS COR_STATUS HEADER_LOG
>  %token <num> TRAIN DLP POISON_TLP FCP COMP_TIME COMP_ABORT UNX_COMP RX_OVER
> -%token <num> MALF_TLP ECRC UNSUP
> -%token <num> RCVR BAD_TLP BAD_DLLP REP_ROLL REP_TIMER
> +%token <num> MALF_TLP ECRC UNSUP INTERNAL
> +%token <num> RCVR BAD_TLP BAD_DLLP REP_ROLL REP_TIMER CINTERNAL
>  %token <num> SYMBOL NUMBER
>  %token <str> PCI_ID_STR
>  
> @@ -77,14 +77,14 @@ uncor_status_list: /* empty */			{ $$ = 0; }
>  	;
>  
>  uncor_status: TRAIN | DLP | POISON_TLP | FCP | COMP_TIME | COMP_ABORT
> -	| UNX_COMP | RX_OVER | MALF_TLP | ECRC | UNSUP | NUMBER
> +	| UNX_COMP | RX_OVER | MALF_TLP | ECRC | UNSUP | INTERNAL | NUMBER
>  	;
>  
>  cor_status_list: /* empty */			{ $$ = 0; }
>  	| cor_status_list cor_status		{ $$ = $1 | $2; }
>  	;
>  
> -cor_status: RCVR | BAD_TLP | BAD_DLLP | REP_ROLL | REP_TIMER | NUMBER
> +cor_status: RCVR | BAD_TLP | BAD_DLLP | REP_ROLL | REP_TIMER | CINTERNAL | NUMBER
>  	;
>  
>  %% 
> -- 
> 2.34.1
> 


-- 
Fan Ni

