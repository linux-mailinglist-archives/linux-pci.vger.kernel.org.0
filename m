Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FEE1C9DBB
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGVp1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:45:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42309 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgEGVp1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:45:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id i13so6600761oie.9;
        Thu, 07 May 2020 14:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gTgkAMD5H8rgyuCMVoM1GZ6vxGFkeOOtPKc0hA6/v6g=;
        b=IlsjMflHyX06VF3afVWQm4YVLZF8teeR5biGx94IxIasyo1+HkgNOYWPRyfFZeRIvJ
         fcfvfN92ZO46UjHB3/tEl10L2SYJuNTuNPgr6tr1auT11eqiSBto7cHMyFpSRsMbubWY
         ytONM0bHSEerbL3+R32OXASpAcDPRisfFH8jb2+BXLqgW7DkOoYI9WdZmVCMERLq0uUF
         JxeNFGJvtnkevRZcJpqOilc2oRpBFUXtOapOmibcen/kFLgY/P8MU7w5qkXs4JQvvFO4
         aizHeqw/SD9+AxYoyRJz0nqBywDY9TFateUEja7+FiONzl60nTuOdJ0FDwU01E4p2fSk
         37Cw==
X-Gm-Message-State: AGi0PuaKzyQhEwoQrikEencOMWb/rs45gVW3QX3SXJY38RQ9SDGxkX3s
        ZCJpXHGVv0j19ZKnrayRI4nIodE=
X-Google-Smtp-Source: APiQypKjY64v9Gi+LayxZeUg1fXvmqL4d6kQfQSJqw/hOeJFCrQO83K05YVCsbUfJKnLRvkYnvJcfQ==
X-Received: by 2002:aca:4541:: with SMTP id s62mr8420362oia.100.1588887926515;
        Thu, 07 May 2020 14:45:26 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y2sm1795675oot.16.2020.05.07.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:45:25 -0700 (PDT)
Received: (nullmailer pid 26907 invoked by uid 1000);
        Thu, 07 May 2020 21:45:25 -0000
Date:   Thu, 7 May 2020 16:45:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryce Willey <bryce.steven.willey@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Bryce Willey <Bryce.Steven.Willey@gmail.com>
Subject: Re: [PATCH] Documentation: PCI: gave unique labels to sections
Message-ID: <20200507214525.GA26840@bogus>
References: <20200503214926.23748-1-bryce.steven.willey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503214926.23748-1-bryce.steven.willey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun,  3 May 2020 17:49:26 -0400, Bryce Willey wrote:
> From: Bryce Willey <Bryce.Steven.Willey@gmail.com>
> 
> Made subsection label more specific to avoid sphinx warnings
> 
> Exact warning:
>  Documentation/PCI/endpoint/pci-endpoint.rst:208: WARNING: duplicate label
> pci/endpoint/pci-endpoint:other apis, other instance in Documentation/PCI/endpoint/pci-endpoint.rst
> 
> Signed-off-by: Bryce Willey <Bryce.Steven.Willey@gmail.com>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
