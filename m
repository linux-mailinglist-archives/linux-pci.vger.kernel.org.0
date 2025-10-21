Return-Path: <linux-pci+bounces-38868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F5BF5D23
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB34188A35A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CC32E6B5;
	Tue, 21 Oct 2025 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGShXXRu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D132E6A1
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043045; cv=none; b=gz7caR9aqaVNVjSq/63765rjNl9YB3jQdsoZoJ72wYbT6uB2R3jqM1TOd/XPKfziMYWJ0JjsRacPRIDElQWDBvm3GRB8euxX9rUgCPIwjEFGprpOz6r1uDXEICQqoFfzr5m0EcbudnzgAHNKANjy2kUtLreTMjDTjOyAiwI3TFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043045; c=relaxed/simple;
	bh=jY85f0BTm4xZQJc0duQtrHNO8Jvd21YwmPqak4eZGgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTmcdQu0fuayg6au78qtjWTSxKkZIV9GutUsIPfFZoLBoEsSKPvbIWuFBcLM0fRedDfTQpyv0l6C3pJteMqz5HW0w9KiZHbc70Mzu6J2cSMCkLE5n2AHNu6c/xklw0Ft3EJGXk48C3vfaURl7PDfaNskic7xqfqGpjzdMvUDkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AGShXXRu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7832691f86cso70792767b3.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 03:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761043041; x=1761647841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/A+ENDDOHSgvE5iS6/3zjzMWUCCsA0O3Bo7N+5kZEq0=;
        b=AGShXXRuJ5ITWwpLzZJQ1VXWyVfQymzdKhuGNk25riiEfXTuHcL4EPvn7WHIF3kH8x
         OhnKKvNizFxKrcRYmouNm2QzTLg9F6U6J1RI+oX2GED2eZgbASnNHqfEOqrZ3TtI9iPF
         J5p310mP9UUOexfReXcEVrhGi5lqK3bZr2ur3ZtTX8FB0jcsNJtRSxI/NCjnUrdGeVLy
         Rc0DkmPO2AB4WidOkKeisoVL7e3xqpHy96K6x11xdTr9NJgOLXMVhbEhXVg9VaRRC5mY
         qnUdIVVTDcJ6Dl1jgkN3+L8UZR4GCsuyyzZd3iqsSfgDUEoErOhqbDjsu9V2mbDNm0CM
         qEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043041; x=1761647841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/A+ENDDOHSgvE5iS6/3zjzMWUCCsA0O3Bo7N+5kZEq0=;
        b=nwSyp29Ayse4IHaXd6HqSmXhxduzlvgNKCs2FURNZ3XNK5aiRen0Yn8rxB9qKy6VcZ
         V9+unbauw7Pl+6LQNrBmSBRa4mC68EkHeEUBaiBEr3wcY840Q9ot0xx3GsrFZa5odDDv
         sQoacQp8hqvsU4XuFFQyVQtdECw0YuXPdhB4mqqoQxTxf0n7z8qIIBnXZo4P094g5lVl
         erh0QY5wJTJaHNqHVlgKsw8tE+ciQBulNPnoy4/c2ECL2mN9D9SWuZPl6Vu3H2anJ6I5
         HReIcnPqiPIyvCzWMs314CT0t+gMuq1+2oll0useiDbP94bIPwI7GE/Pe6WGmcp1sHe7
         zfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrnyZVxdUM1CFWE0k4rWzTNHivsDx+zjGipWuYcK2lWiKQla1BWtTqGvSO3pWqWeLAfiv3EFoqEVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MC8cl3sJndvkDqtYTPWo5MOB+aQCHB9IaN6jcJbwbhCiAmwz
	+J4qleMMZrii3urj6Muz9eWpWzoROyVc0KvwYad/ATG8AjY9hBFiKScaJP71ir/rIgoqJGiNtXv
	qZr2rMD53OYBmwVL7rEcZSGbnMEz6wSw+dagKOfWVdA==
X-Gm-Gg: ASbGncuLj4MVdt5ENl8JEJUVNvz7jBjMRZJQTFU/+uT1l1wy8IpHx8fPVK5ZPYec27B
	Kw6voJkn2qbAcZtZfu9DQvDQ+c/axHpT/zgqvQ8Am4KMAK3huUosA59hb803owHmnObkyKZ/w7w
	0L85XUxR7rKJD71hmLC15VtxEVJFyD+jCRpyoBDyHNAzY8Cuov+0mDmW8WwVvaFW6zcm17YjMlQ
	nnmvsGL49CRwiNG6lpISD3YS8Yfdst0PzekTvODOzfPq0lfnrXqY4S0iP5V0w==
X-Google-Smtp-Source: AGHT+IHoJvOW0/D6MieN+AKPcyEQMvpsuZMp0uNhFRTQ30AAyYSDWJV0Zne8KGeUusjjnlwIFn81QpMo/9iO3PYky6c=
X-Received: by 2002:a05:690e:134a:b0:63e:34ed:a11f with SMTP id
 956f58d0204a3-63e34eda840mr5668133d50.27.1761043041095; Tue, 21 Oct 2025
 03:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-9-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-9-herve.codina@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 12:36:44 +0200
X-Gm-Features: AS18NWD7omNxrmhFqrJYVWmQS9VjywGnfIZM0lhZMuwUv9gCSC75_xRcZL7iDfA
Message-ID: <CAPDyKFr8C2VifsPa4YRPBEt4iAtM3eqnpH+C6wdSASF10fMO0w@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] driver core: fw_devlink: Introduce fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 09:17, Herve Codina <herve.codina@bootlin.com> wrote:
>
> Setting fwnode->dev is specific to fw_devlink.
>
> In order to avoid having a direct 'fwnode->dev = dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  include/linux/fwnode.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index a921ca2fe940..a1345e274125 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -231,4 +231,10 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
>  void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode);
>  bool fw_devlink_is_strict(void);
>
> +static inline void fw_devlink_set_device(struct fwnode_handle *fwnode,
> +                                        struct device *dev)
> +{
> +       fwnode->dev = dev;
> +}
> +
>  #endif
> --
> 2.51.0
>

