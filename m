Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC2445D63
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 02:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhKEBl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 21:41:27 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:35564 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhKEBl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 21:41:27 -0400
Received: by mail-wm1-f43.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so8553868wme.0;
        Thu, 04 Nov 2021 18:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AdvEedg53EmklS1heCqwrwrop81P8Z504Yc+L9o1ZtQ=;
        b=NpfsMTTwg8ZlDo7VKukiA3lS0bS/9nMVi8sEvyNuIH6Q8ydBiAqXtkPhpy0wqX+eDJ
         i/uyqrTqjlUuStu/Rdw0PgaDtSYMbgwH9e8fLc++tqjbXo49sEwh4OyAdikjvqEMqbU5
         8qt+AsZ92R0NwgQUCKhmj42uclaeIsSKkDif0v9zPZvYPS0VOUCsQSQswTBJKURWZ7MW
         VV7Tm1oGHT0G2M888RKrgpppYU016noq0EN7T8FkQModr+BcexRUFeYv1e6ILLiPiR9s
         GmBP5tkCMexmvHoOg5QI8oIyXdqSpqowBoMmkkxCnO/l3pUew4DNsevSp58VB1i4SIPR
         sDRQ==
X-Gm-Message-State: AOAM531QbEkEKhhj7ZzQWUqGFAXVsD+wuZ98uBUTilWNr5hfs8EmITGJ
        CWOfOVl+eD26eqR7oEO+gbM=
X-Google-Smtp-Source: ABdhPJyo3pJfWTiXZPiSWPp8sQKsFDzomtRBr5SzVFS+PZMUU/Hvv9h3ZDi3IbnXXSOGdoLSsIJYeA==
X-Received: by 2002:a05:600c:350c:: with SMTP id h12mr24377035wmq.123.1636076327425;
        Thu, 04 Nov 2021 18:38:47 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l16sm6726686wmq.46.2021.11.04.18.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:38:47 -0700 (PDT)
Date:   Fri, 5 Nov 2021 02:38:45 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     cgel.zte@gmail.com
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] PCI:vmd: remove duplicate include in vmd.c
Message-ID: <YYSLJaisv7wMC1LZ@rocinante>
References: <20211105013321.74364-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211105013321.74364-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> 'linux/device.h' included in 'drivers/pci/controller/vmd.c'
>  is duplicated.It is also included on the 13 line.
[...]

This has already been take care off in a patch sent earlier, as per:

  https://lore.kernel.org/linux-pci/20211104063720.29375-1-wanjiabing@vivo.com/

Albeit, thank you for taking the time to send the patch over!

	Krzysztof
