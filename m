Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD85FC7DA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 14:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNNhu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 08:37:50 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:38978 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfKNNhu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2019 08:37:50 -0500
Received: by mail-io1-f49.google.com with SMTP id k1so6799110ioj.6
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2019 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUdhNg+72/RtwmrV6AWV6mpB24rxemJqtcAcSQr09S0=;
        b=Sw0PAKVJfVVqsnA/UpdGgKs1f/ZTAJ2foJg0EjXiJrWcwKWaRnwVCrvprlbk+lEGXa
         juoaaLwhOLsBumRkuSNSkYK4TEdldnFmsnwkhtcUr2bIKylk/jkaP+LYVseNJVnwiG0j
         aQsu8IeNFzgYu1arIaoRi9zhY9FMPXRgQyaBaKrVtYoq7QDaFWByo9Nsf3KSVljagiMP
         LfFHvcmi5765dheOi6PUwkU7IMNoeaufaQUval04uYXI0A9RlVPtd0drFOFiP1alCSR2
         JlinEy0QQEp08rCWLlKljhP8Vv90+IzF/m1FQZnMtjheLOEnhcvWZpW2CLNWvZU+AQh6
         tjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUdhNg+72/RtwmrV6AWV6mpB24rxemJqtcAcSQr09S0=;
        b=J32Aq171ap1JdeRIpY5DnWXup2N2iGK76whS7lNmUMF/P/ilD58r2W9thvyKku/KkG
         HGZpgxrDirOP+WUFEk6bp8pqWrd0tdqgtAwkxjihkpXNvm0/4C9YBpkxq/QiH9BqClIT
         EbBNWrZ0YIMkUds/9a2x/37whdqobyHhKgVgg9cuwRLvUdsWqsRWBD1/7F150O9qvPAI
         XHEHyp1qd++24dS3GXBBgmENAEWPXSLQT2Vaom8rq7b8fwKciZc5Z3bvCayA5hY3Jg2s
         q4+m5ztwfoc2S1gjhx1AMIiRRUArRvhTNm8Gg51VzfmFR/Ys7iRYKNbYdmtT9YZ7Njxc
         cb5w==
X-Gm-Message-State: APjAAAXqVUSviMhIjbta8DA+uzuGTcVvnC0Rczdp3yf2JPu34mu7+fW8
        spPoc0smjCw4uLlgG0MMhi/dW/bljK+C2XETSZwSz4ik
X-Google-Smtp-Source: APXvYqyWKXlZxP7+m938s2NtnVh7uWUzz/3JLXFMrU3CoI7uc/fCFHsxayO2EcXrVdJe4vG8AYd6iO08LgT0HlvgUr4=
X-Received: by 2002:a6b:e315:: with SMTP id u21mr9070641ioc.192.1573738669604;
 Thu, 14 Nov 2019 05:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20191113094035.22394-1-oohall@gmail.com> <5a12d199-fa1f-5a60-05d8-df9edffbc227@linux.ibm.com>
In-Reply-To: <5a12d199-fa1f-5a60-05d8-df9edffbc227@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 15 Nov 2019 00:37:38 +1100
Message-ID: <CAOSf1CGVjRC6PfLeoJWQe4WwhcsbrK-=1867BqiGaaRGz_LVzg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Disable native PCIe port management
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci@vger.kernel.org,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 14, 2019 at 7:39 AM Tyrel Datwyler <tyreld@linux.ibm.com> wrote:
>
> Nothing but pedantic spelling and grammar nits of the commit log follow.
>
> -Tyrel

Thanks. My speeling is bad even on a good day and it was not a good day.
