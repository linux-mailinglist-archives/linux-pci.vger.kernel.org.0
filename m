Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E642B23A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 03:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhJMB37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 21:29:59 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:34381 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhJMB37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 21:29:59 -0400
Received: by mail-lf1-f52.google.com with SMTP id t9so4540820lfd.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Oct 2021 18:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XgJcRPZbOFPuAtex4ialQkqyxELVjnwC9dHzcaKkeTA=;
        b=HcdZKzITNDdYbu8Io6rNeITq6cSJJ106eRswwd173ewbxzlL6pIIgFLXG5SUveoGki
         d8hP5STPW4XEDiVr0skeb7YD57qY8o/iH/hjWO0EICsaoPD3BjlNWyZEbaUd+U0hzO/X
         EbVWVmh8YrkPA8ZKGFaaWgC+1Urn+dTR6LxX8O05v8YOheJuIf2bua8zsFQZe5iBaM7P
         gx+QvZcTyJ0jexoO9fu3uPpoC7TPLsWzJ+3XxGvYqgIT+EA54i2IZ4UDbcz34V6RZSVM
         oT1YCuyKqXRlFkEe0mG1dfsKjWyjeDBtZwlwVpDHGlGFxbPipyuoecUXhrHMQ5it0I9V
         QCZA==
X-Gm-Message-State: AOAM530xrQnAFk6YMDA97TWpUX2WibFx9/QTgDWDYbuCHaIrlLnM/n1p
        eAA7WQrldhFzt2Z90tNfGMqURgifhkg=
X-Google-Smtp-Source: ABdhPJyY4Z4Tiw/cZ3rVl36+N6Vq3MZnTUYdnr5bYRy/6xVorMuiojkfKrLj2RkoQTsJucqzNuNv6w==
X-Received: by 2002:a2e:760d:: with SMTP id r13mr32409064ljc.355.1634088475982;
        Tue, 12 Oct 2021 18:27:55 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a16sm697417ljk.100.2021.10.12.18.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 18:27:55 -0700 (PDT)
Date:   Wed, 13 Oct 2021 03:27:54 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cpqphp: Format if-statement code block correctly
Message-ID: <YWY2GukTHETd33eW@rocinante>
References: <20211013011412.1110829-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013011412.1110829-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> The if-statement code block as seen in the cpqhp_s

This incomplete sentence above should be removed from the commit message.

Looks like I must have accidentally undo previous edit before sending the
patch through.  Apologies!

> The code block related to the if-statement in cpqhp_set_irq() is
> somewhat awkwardly formatted making the code hard to read.
> 
> Thus, update the code to match preferred code formatting style.
> 
> No change to functionality intended.

	Krzysztof
