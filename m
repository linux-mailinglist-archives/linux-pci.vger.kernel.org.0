Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0E34B332
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 00:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCZXyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 19:54:03 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:41609 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhCZXxg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 19:53:36 -0400
Received: by mail-lj1-f178.google.com with SMTP id f26so9230647ljp.8
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 16:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=klEY6MAuaf1tQSTVwnzoetEJxHTL/+NzhZHmVVkbjzc=;
        b=mJc8O1JPdnQgCDj88q4VQoXs8PqfQ5H5juxdMNMNVmIxLomj7itkBPJ401FeawcwEX
         s4mJMC6vnsK78cepk/o/0sNLWOcTtULyeT9jdx4R46AAmJG+N0saJYbtRZAQkI3m/Z1r
         /X3nvbYegJ3jKkIYy1R0eDAMpc9oWVYnu6Cyn4zVdO7p60dMB9UecrsLRDsw8WYufeLe
         kJ7GhexBGyJ+TvNeV5Ltp8uJFtqEAVPItTizFbP8iaLGx/Q33WBFagWEfP9sX4xF49Jv
         Kocz/9oo+9xI6pMdNgCvlQWjMO0/+PLKiLqTjQl61uJeIlGWIIMbom+0rEdlQpYB8bnj
         Zs8Q==
X-Gm-Message-State: AOAM532FpCTifImJny8PfXrceQuvDmn8OK0eVCjBAxVOJw+IxFafQFUl
        ON15IDCb8GfO8ArfIpbe3Ug=
X-Google-Smtp-Source: ABdhPJztF391GdFpc7uqifsXjc+5QIKMehK72VLylGMRXxzdbwwfFNhplqnoMIcK4CogTKVKXOEJSA==
X-Received: by 2002:a05:651c:289:: with SMTP id b9mr3874733ljo.400.1616802814755;
        Fri, 26 Mar 2021 16:53:34 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d4sm1017147lfs.45.2021.03.26.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 16:53:34 -0700 (PDT)
Date:   Sat, 27 Mar 2021 00:53:32 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] PCI: mediatek: Configure FC and FTS for functions
 other than 0
Message-ID: <YF5z/LFisXr3b5yi@rocinante>
References: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
 <YDK0fr/UiKjit+ty@rocinante>
 <20210326155104.GA8190@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326155104.GA8190@e121166-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

[...]
> > A small nit.  The commit message is missing the opening quote, see
> > Bjorn's suggestion:
> > 
> >   https://lore.kernel.org/linux-pci/20201104131054.GA307984@bjorn-Precision-5520/
> > 
> > But, it's probably not worth sending another patch, and perhaps either
> > Bjorn or Lorenzo could fix this when applying changes.
> > 
> > Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> Thanks, I will do. Can I apply it or there are still pending review
> comments to address ?

Nothing from me, so it's good to go, I'd say.  Thank you!

Krzysztof
