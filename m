Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5B126355
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 14:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLSNVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 08:21:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726701AbfLSNVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 08:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576761669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=YMGe8Auk09W0JY3cX6XRrb5q7VUvG3JiRylPfUJy33gRZImS0cIU3VvOOMtWmnsepzY5Bw
        Qb9KjRk6VJ7v76DIEjsu7ALRcw6OEfMQ7dT+0HsNTKgmR/zRB9hHZsxRTlXOKW0+7YK7+k
        7cR8KMk5Wdx9F6QV2qiWI6pBzv+ioPE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-WRfRxh3OP0W1hHEH5DLgLQ-1; Thu, 19 Dec 2019 08:21:08 -0500
X-MC-Unique: WRfRxh3OP0W1hHEH5DLgLQ-1
Received: by mail-wr1-f72.google.com with SMTP id 90so2353769wrq.6
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 05:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=ftnycFRbpw9iAqlWIm/KnCoJIVGlnribSECVycKRMPJH9zbSjmIm1yyIG2Nb7Oc0Pl
         df9kox9mQaQGQn6AxOXdEC7vosWuz3aTyWsZ7FnrA1NDzUkQGhjmx1+fu5mnM0aV6EoW
         XJ5igYkAW82kbuF3WJDat/O1YFlEmhxTHPIeNsjHSHQQ/2p/AZNhr/Rgdr29ZslLDLor
         L4/fqZHRVbqx0BK4sB/ZkKwDeLfa64AIprmbhjgJUUqeyjjksXKYnV3IaSYPP1/cqv1S
         CyzJA7A7Cn0mGhXluecqKoML4gf2F9Q36E40EFsgCJEMOAWOu2Kpnkkdl65HA46ympiv
         NRlg==
X-Gm-Message-State: APjAAAUzPRuwpv2FpKEpSovW8sN2KCQIilHOXuAM1X6EIgx6WZfx8QYI
        quyURG932+R3BCmcx0oV6ycwhVADRmxmg0yxb5+Tir8Drrp7S+JZFVwqVUWNJa7yxUDU1SAQcbG
        bp/WEhiE2ij7qWNPwuxz8
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922286wrv.269.1576761667270;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYsmkicq1CgpePFwwJNc2lMQupRm5P+aon/r1P4LvdWHpza4ghagzA9OygT/h18nUeOHn+jg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922266wrv.269.1576761667016;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
Received: from localhost.localdomain ([151.29.30.195])
        by smtp.gmail.com with ESMTPSA id 188sm6488919wmd.1.2019.12.19.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 05:21:05 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:21:03 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel IV edition (OSPM-summit 2020)
Message-ID: <20191219132103.GD13724@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2019

Argh! s/2019/2020/g of course. :-/

