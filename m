Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1D434C47
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 15:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJTNnr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 09:43:47 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46853 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTNnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 09:43:47 -0400
Received: by mail-oi1-f175.google.com with SMTP id o204so9630883oih.13;
        Wed, 20 Oct 2021 06:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+f9jX4gENJ9ZTepD8KkqshKnHoLg5Qaf4KS0HjJ+5g=;
        b=hmDTM4imIOVluJqVeOEtsi2VHf2gmChp5WS+X3FGKhMMsKW4dGNf26BQFQK2YWLd8L
         VFHFtzADPmTuRuiCFZCFaKrDzVXmqung9Mv5kgGi4/RZ9tL6UNx5AB+SXayL3Rh6Ee2A
         Sw3hTGPk+8PHYDhXEy1zGuecJ7dhrEvMg9qdFTcDKDg4GNWledZJILSCEqW2uS6/CI4g
         mUN6xIyq79Gwf9b2yW+12dF3WQ6UyQ5Pro+5DfI0oP0bZy6esE6QPVdaSJWnssWUp63W
         c5C9eyICXOK8TeHfUfE5uhtW2JNjnLv6OQGGSU3nWvcbs3Ouq5I4CyexmkNFl79K2idh
         qMTw==
X-Gm-Message-State: AOAM532uWNrmy41njGBQOk6dihm7jdlMFGFeqBszyLVsyVOdVL7EIJ0X
        s+ZgsdIZtTwFuRC8WISeTjvXu/aOBA==
X-Google-Smtp-Source: ABdhPJwUOSFqTpPy8Y5D71BOVCigV0itLv+Rj8nhwBqumAIK22KTKiHdOIOhP6DCgvowuCfdDs2saw==
X-Received: by 2002:a05:6808:2389:: with SMTP id bp9mr9574873oib.140.1634737292382;
        Wed, 20 Oct 2021 06:41:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s18sm465022otd.55.2021.10.20.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:41:31 -0700 (PDT)
Received: (nullmailer pid 2247038 invoked by uid 1000);
        Wed, 20 Oct 2021 13:41:30 -0000
Date:   Wed, 20 Oct 2021 08:41:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 02/24] PCI: Set error response in config access
 defines when ops->read() fails
Message-ID: <YXAciic84q49qoZm@robh.at.kernel.org>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <b913b4966938b7cad8c049dc34093e6c4b2fae68.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b913b4966938b7cad8c049dc34093e6c4b2fae68.1634306198.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 07:58:17PM +0530, Naveen Naidu wrote:
> Make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value with error
> response (~0), when the PCI device read by a host controller fails.
> 
> This ensures that the controller drivers no longer need to fabricate
> (~0) value when they detect error. It also  gurantees that the error
> response (~0) is always set when the controller drivers fails to read a
> config register from a device.
> 
> This makes error response fabrication consistent and helps in removal of
> a lot of repeated code.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/access.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
