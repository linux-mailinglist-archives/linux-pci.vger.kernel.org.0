Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E554428B7E
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfEWU3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 16:29:39 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55672 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387835AbfEWU3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 16:29:39 -0400
Received: by mail-it1-f196.google.com with SMTP id g24so5160610iti.5
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=b890wSvSu6wn7E/uDIjk2vqaDgCqNzWOhAkC3m9/u2s=;
        b=Oh21H9o532d2n/TnnynzsE2ljIHzgvh1GxeZTfW2qHwe3qovfNr5GvwkMjmzzVASMz
         Ia9juX5Ktr3S8qTF/YJHNxCt6CaUVoykR+EYa013yQLepgHgtg0j0znllhIvqIAShZDw
         4WUocTAH0WMfZVqIMAevGQTiRV3Q7Wo1FYCD7Idb8bWJrytQ9B+mCrvaW/Y9kb3ddC8w
         qi0s1otayOcCHqXNqVEvIuOiPH3oe2ibsYGcrmU1UywHhpLR8LdjYq0apUM74Ra8RS3F
         T+zDEyFLJBLLEUvOaReB2N4eiDd3iTFZgg/vvjmfyoNCZXwF2JsBICr3Dggkrv/bqkih
         e3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=b890wSvSu6wn7E/uDIjk2vqaDgCqNzWOhAkC3m9/u2s=;
        b=fZ4q/A2QWHM2a13koOTLDytvFcjPM6NtQ5XplV5XlO/IRln/Ys+6kstFbl+69hi69C
         LkdCdrZgk162SdEnZ/RufghVltme8oako2JCGYliZOplxlifn0B9MRTVE4poz7EtSXD5
         JiLw0sDaMBHPMcJy2m3W1aDomxILBOkzGfEMyMTXdT9zzY+6k3RjEkHNEbcV2i4MqziR
         AKfT4HnOncfb5S7v7yihyuh9beMCk0vBEpBZ1OOgsU4hbl28lgRv6VZ0qGPWexFt4OCj
         5MzRGh5VjfpVtv1o56s79YMwQSdlPjZSxUEVUaIwXKcDtHekYVRmkFLj4wAkapRnyMfz
         m6Ag==
X-Gm-Message-State: APjAAAW8epLLyxaJD6OqeYKC++MIe6gUYdDWTLQwfda+lb1/UANkBOot
        +XcHjUwAZr+46/g74/6PKtjDYQ==
X-Google-Smtp-Source: APXvYqwoBcWiq9kt8e9AFxHiOgATa2Rx2JHeWpNLhTfaKeetKbRVbLGHjaraqPj3ixUZof8y8n2B5A==
X-Received: by 2002:a24:d43:: with SMTP id 64mr7541897itx.114.1558643378930;
        Thu, 23 May 2019 13:29:38 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id i25sm194019ioi.42.2019.05.23.13.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 13:29:38 -0700 (PDT)
Date:   Thu, 23 May 2019 13:29:37 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alan Mikhak <alan.mikhak@sifive.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com
Subject: Re: [PATCH 1/2] tools: PCI: Fix broken pcitest compilation
In-Reply-To: <1558642464-9946-2-git-send-email-alan.mikhak@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1905231329130.31734@viisi.sifive.com>
References: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com> <1558642464-9946-2-git-send-email-alan.mikhak@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 May 2019, Alan Mikhak wrote:

> From: Alan Mikhak <alan.mikhak@sifive.com>

Please drop this line.

> Fixes: fef31ecaaf2c ("tools: PCI: Fix compilation warnings")

This goes down below with the Signed-off-by: lines.


- Paul
