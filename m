Return-Path: <linux-pci+bounces-23095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E59ABA562E1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 09:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221A3188E3DA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383CC1A255C;
	Fri,  7 Mar 2025 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOm4uEvI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4BF19E971
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337217; cv=none; b=DOwcN6uhhfM3zrQNm1U/bm/aX6PBsc0Dpg7d0r5PbMgMJpLqgV8Icl/7dYvnhQcnvYhp3BjUZRePF4YE54w6u14P1VI+Bt+9tVXWV71KPI6hKQ8sf/n5yF04z+kkD9i/+Uhxx1ix3CZXDjr+h6QNO8ecvjKwGFHQJZSi0S7bvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337217; c=relaxed/simple;
	bh=2tCICcAJq3mMEdu4ZDVty00I9VzTBbw0rWKed6g0y1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVzzQ9l359lS8tCt/32SUhMLrbzNNmrAagj9EuYavpoD7LcvPAZRvAri1CLXdf7V2yqX+Chhgke2Gz8ekLXJTiIJiKvZlV2eRiBM0I57AnIPC0kUE0MjHupx8xZZwp5uJSJDv84p0E9wkxRYxFIDg+h1m4d+zdfiZ31S7g0G15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOm4uEvI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso12200465e9.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2025 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741337214; x=1741942014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CURT3euQlvlJ1zWGuJW+d+Z8hIOMnrtr7tJOIL93/Ac=;
        b=eOm4uEvI8zz2mi7l1F08LqQwGSTneNiE/vhatQFpT8E9tJqTa3rnU+anEXpx6hH+u4
         gJSsknIRQy9YW4/mlisDichoRvLYAOOYLqqlGTGyE5zeBN4UTE0m+y910WMjQPkOuGcx
         tSDruNw77Bjtq/1irOHSeWcD5rs7CWvUiAfhINkPfkM4uw/3cDZRj7xvRETgZ7rn2wo+
         MJn3ul63qEepQLexx/Zmwy/5rwMlvpg8qamZVCPTow0U39FNr7L9fGwzQHzGvHlJtOTd
         jb13iLfAD9UExdezgrYHiMGNs3knu4hMlMDpmQ5S9wCur9j+dTNO4f8177Jm11s0E30e
         zqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337214; x=1741942014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CURT3euQlvlJ1zWGuJW+d+Z8hIOMnrtr7tJOIL93/Ac=;
        b=Jj1tKX10R+KhLuDfQWYMEq8qYQW0CP1qTOFdUiusjkF864szrCbGc75Jp5D4LHIfVT
         Rs/EA5XBqsMxy4A09Mk/Kdjqg1I59wSD93uZPWuuNf2pPAWh+D7MDyfnTzvoM3uArIJ9
         cIYYIcf9hDqMCG0ArVhEXMAFdEbYrfy5CjF8q8omvpBNsH18oINp/kvATi6mhxcZdrXp
         43rgY8pjqVa7e9iI1+etVHMzZ1YCOI3rT1WxiIxTbhcMs18ubumFpRogWS0hXrYbcsXP
         gSgOViPe9l/09UBNAfKNdloFtdOkt0JqD9qTmRSBuXvrorckYOMCunmV6OrlboO5O/jr
         JrHA==
X-Forwarded-Encrypted: i=1; AJvYcCXdYBuhf6i+8alktNlzhhsJD+Iw2qRU0MueoBapIwQkJUHeNv/B+N8lTLfgYuoOW+26Vra59AV2KU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxNyw6cqDHJPWqLxZYeqVu4AjQdsxAgUtcKGHV+4Qr2Yhsikx
	GlXu+2CSJb3nErYko6VVlEdl+kcpAa5yAgkZc9GHrIKesXCHk+gy2cgFCCuFcmE=
X-Gm-Gg: ASbGncs7nzIbHVbFjeyq/lcRVorDkkPU3xzJ+qWaEgv6gUSq+e4oSwFwVhadE83M23a
	OrXxkN8GLShJyFUnVWruyJuji6c9MInL4N6uujGQnpVm6D4LNOi4iaq9am2fQM0DE0Jm0OPto9/
	dPcE5jnctIC+qNvLCdvj3daWEqvaf//hEncWBq6plVuzmYWicMVcuYDNLq7MBmkfpMEiuVvZbqb
	OC1TzxojiexAfifUMFW8/JbOxEWzBb+fuV6IDimUDFpwtFRK5TS24d+RQnAyUytsj9ewlTOq/2P
	fGTeU88UMoLSnot4QvzxxlFz+WGn+LO6zZl+PJjhJ6lZTktghQ==
X-Google-Smtp-Source: AGHT+IEi5jnq9tYBMNZz/LbRpDjpN8pjvqYyLgYrE5AUx25gXQmhhihjTg9/axLoWRLHysByHJibOQ==
X-Received: by 2002:a05:600c:4f91:b0:43b:d14d:8ff2 with SMTP id 5b1f17b1804b1-43c5a635695mr17068445e9.29.1741337213638;
        Fri, 07 Mar 2025 00:46:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c102db1sm4643611f8f.95.2025.03.07.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:46:53 -0800 (PST)
Date: Fri, 7 Mar 2025 11:46:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: Fix double free in pci_register_host_bridge()
Message-ID: <db806a6c-a91b-4e5a-a84b-6b7e01bdac85@stanley.mountain>
References: <cover.1741336994.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741336994.git.dan.carpenter@linaro.org>

Calling put_device(&bus->dev) will call release_pcibus_dev() which will
free the bus.  It leads to a use after free when we dereference "bus" in
the cleanup code and the kfree(bus) is a double free.

Fixes: b80b4d4972e6 ("PCI: Fix reference leak in pci_register_host_bridge()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/probe.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 819d23ce3565..c13f2c957002 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -957,6 +957,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
 	struct resource *res, *next_res;
+	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -1020,10 +1021,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
-	if (err) {
-		put_device(&bus->dev);
+	bus_registered = true;
+	if (err)
 		goto unregister;
-	}
 
 	pcibios_add_bus(bus);
 
@@ -1110,12 +1110,15 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 unregister:
 	put_device(&bridge->dev);
 	device_del(&bridge->dev);
-
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	pci_bus_release_domain_nr(parent, bus->domain_nr);
 #endif
-	kfree(bus);
+	if (bus_registered)
+		put_device(&bus->dev);
+	else
+		kfree(bus);
+
 	return err;
 }
 
-- 
2.47.2


