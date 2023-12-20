Return-Path: <linux-pci+bounces-1250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C481A8BB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 23:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EE61F2350C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5708148CEC;
	Wed, 20 Dec 2023 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrfgpqzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099354A99B;
	Wed, 20 Dec 2023 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d32c5ce32eso9510575ad.0;
        Wed, 20 Dec 2023 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703110025; x=1703714825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLm12/GG77FpeoFOiaIDOMFgas/EV0i+WeY7p7Readk=;
        b=IrfgpqzN6NmbTLN+NjHLdasoI6d4j8c4GQUtVIg6MNYLuDy8Bvh5BwwP25fZqwbXlv
         cS//Xyk9OD0gy4/Rj/S/ewvJ8FE1vZjiRbhMGSnvBJAaCuhpIcmi8L4nh2xxvtrnT3GW
         T+u3ifz6oqpcOu0FGmEF04muWUwAheswn/Lj7blQiaxrdtBd2gJC55ZH6KnVzgX3+oqc
         itMte5nE34ktlxXJPaPtrhuptr2W4eGwIzK4htUIZfxeuwrT6MQPCGEPATZX0bTITrsc
         f7eEIeERvuHfb6z9TNHlATvc4PyuY7Qeh86WWIJaeGt+zqStu5OVDgWj6piSETxx1odg
         FY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110025; x=1703714825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLm12/GG77FpeoFOiaIDOMFgas/EV0i+WeY7p7Readk=;
        b=QKx/iZvgzw/JUC8fGNPHZP++m6ycTsN1Q9JGEyZQJPibh72IIj+GT8NPFoWsLL3lqN
         TMAE915F0EAm6mE2B3I5s94CFoyymjHYYb1TaaI0cYY7GjmFA1xbjdquE7wTA9wCaBDY
         8BBV3gFjnY76WSWOfLkdSSq/vvBQw3/Lm6szf6aMFRJD5igsHVcBJ9LFO2WGorUOmyp1
         U2AS48R75CATzZ9ZzB1GWlvyFJ8RwJ5nbgdbMBiy0mJGTM5mKipEFIoZ8EO0R/1dmHNM
         3Q5Gga5YXR+JyWy4aNnTSAjR3qoPtKl04+aMw9PTeZsrespiNUnQEztubyYVuIPh7MAa
         5b0g==
X-Gm-Message-State: AOJu0Yy9IqXG/eNb1m51zL+Aj7eX7bagzPihzIEj/582Mg1ePqsVx33I
	qUAF2XstjOVhLzr8adg3SS8=
X-Google-Smtp-Source: AGHT+IEAtbLAtPV7R5ODM4DzD4cazssVJulhjH+FWTj49du60RYVzOIw5bo14zqHkIGscZt+8weIaQ==
X-Received: by 2002:a17:90a:f0d6:b0:28b:eae9:dce7 with SMTP id fa22-20020a17090af0d600b0028beae9dce7mr359516pjb.47.1703110025098;
        Wed, 20 Dec 2023 14:07:05 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9d7:3461:3155:35d4])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090a394d00b0028adcc0f2c4sm399639pjf.18.2023.12.20.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:07:04 -0800 (PST)
Date: Wed, 20 Dec 2023 14:07:02 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v3] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZYNlhgAzDPaLX8EZ@google.com>
References: <20231220-thunderbolt-pci-patch-4-v3-1-056fd1717d06@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220-thunderbolt-pci-patch-4-v3-1-056fd1717d06@chromium.org>

On Wed, Dec 20, 2023 at 03:28:32PM -0500, Esther Shimanovich wrote:
> +
> +/*
> + * We also need to relabel the root port as a consequence of changing
> + * the JHL6540's PCIE hierarchy.
> + */
> +static void carbon_X1_fixup_rootport_not_removable(struct pci_dev *dev)
> +{
> +	if (!dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon 7th") &&
> +	    !dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon Gen 8"))
> +		return;

Sorry I did not mention this earlier, but can these checks also be done
based on vendor/product/subvendor/subproduct IDs?

Thanks.

-- 
Dmitry

