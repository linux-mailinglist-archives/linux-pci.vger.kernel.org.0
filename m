Return-Path: <linux-pci+bounces-1574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C7820B3C
	for <lists+linux-pci@lfdr.de>; Sun, 31 Dec 2023 12:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C071C20B2E
	for <lists+linux-pci@lfdr.de>; Sun, 31 Dec 2023 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1429A2;
	Sun, 31 Dec 2023 11:15:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7533DD;
	Sun, 31 Dec 2023 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso5875456a12.3;
        Sun, 31 Dec 2023 03:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704021334; x=1704626134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn9INRXeOqAe5x8q1JbtdN51JxIWlKrv4ENVbxcuo88=;
        b=ehqsF8RaZG+NZ2aM9jk8ZyYoT74UfKroDMkiOXZFyDshRn3gHP5R1mPKZzm04hyZ++
         iNCrx9TIk1V9LZhzq7mb7eUi8oN+J0GQOIJzAUJgK5uk7P353R7xDOBdaFndq4Q0c2Mf
         tzdfIupasyj//v3JcvmFT3AoLw9fvEbVva3KUNLEV08TuiCBl487XRdqFUOAkYzVQ8vr
         7PlO/twnLksRcHIs0sX0bEAXv5jy2qT/NBqW1zHQGN7Xd2G5mX0SLCnbl7q+PzwiSaaB
         5gpLyFdM2e5gpSl3woWernBjr30pAGAQ5PPTQa3QLlZ4ZauNxuQ3JpaIg/soJhzKv13Q
         IfNw==
X-Gm-Message-State: AOJu0Yy9oOeGI9oGHyxI9gwBZbFzWSqWFX8bUl+yMXKePmETTCH1IhUA
	HZ8iKGTIHZSpVsBOKat6D8VXpp8iwsqi3w==
X-Google-Smtp-Source: AGHT+IFi5n1dqNXZ7bANBrTBPkGcqmsCloZ9U45ua0oJhYOVdiIHrbmas2Q8r5xseDeFdqkm5bc3sA==
X-Received: by 2002:a05:6a20:b48a:b0:196:6db5:5164 with SMTP id eq10-20020a056a20b48a00b001966db55164mr3842215pzb.72.1704021333982;
        Sun, 31 Dec 2023 03:15:33 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id ff17-20020a056a002f5100b006d9bb753d2esm11463399pfb.166.2023.12.31.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 03:15:33 -0800 (PST)
Date: Sun, 31 Dec 2023 20:15:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] dw-xdata: Remove usage of the deprecated ida_simple_xx()
 API
Message-ID: <20231231111531.GA3813474@rocinante>
References: <cc01721cec2d416d7bdf47086943b17ef44b7286.1702966181.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc01721cec2d416d7bdf47086943b17ef44b7286.1702966181.git.christophe.jaillet@wanadoo.fr>

Hello,

> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.

Applied to remove-old-api, thank you!

[1/1] dw-xdata: Remove usage of the deprecated ida_simple_*() API
      https://git.kernel.org/pci/pci/c/0171e067d7da

	Krzysztof

