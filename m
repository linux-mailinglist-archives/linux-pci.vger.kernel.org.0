Return-Path: <linux-pci+bounces-38255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D1BE051D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 278B34E1A9C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1129B205;
	Wed, 15 Oct 2025 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="g3MrjDc3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2324E016
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555484; cv=pass; b=K9xOU8YBT34H5PQPr7fGbmspjXiWCUIfPSqrWAQzBYdvgUaVCqOXi6+YiSMIKaihRLMk9LoXBIkB66TO6J6y1tvP0GekG3yj0LCtu25mzOQtqU3F/eFfwSBAElfc+u6PJjfzFY5h7JPbDhTxCbGlH8xeH+11YdtEdoFe0Mj0L9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555484; c=relaxed/simple;
	bh=ALDan2UmCzDgMevzePK7Ovp0XxWdBTc5ElYNSxvSiv0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZOvjADfM1jUtE6IoID2LOo057B9RlcEgfmQLUoUt5Pg4QyyOsfJLlA+tzs4YBZSJTfk8+2SXnHNLApW7N1LtiGRHJx+lkz7R1ZqX1VqKPOLnnw1KHmxbo0MXM6nffKTQMFkPYA2+d2YeNliniPibd7NOfA9rIwS/rrnp00Au/6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=g3MrjDc3; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1760555118; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Fi/votx7LtihrhgF+8Lkt0HAGZEQgrXm8JMVlc96Q9i8WXU+YiVC26lQu0VCLdCCu1
    5QBpqHYTSLigkwMKxBwvHUyKp7WqBoYZ+1SXFSoAyU20PK9n61YYeQbG2AxzwIPgGqeu
    ZFCR4EsPIPN8r4s9OMfswWECpJzi/mwkWuUUMZPijtl05nPF3kPyE2dt1gAsS7mzSxf6
    5TflAzeILga5QPVV89an2144zerJKwAZAQnqnZBsUQbc26nCZ93Y9R4ZtemTFqiq/e6j
    yBGyabnuUZBqucFHWUu98wvF8Etx/Y4suBVuCoUN+OywXVikuXyhpV4oQMpIVceQRdSj
    gqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760555118;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=8ihu2cgY7TBPXK+YLTTlEOZ5P7XCwqiL/DVyBqlxg28=;
    b=iQX5uWJ1XQ5JAflYdbMOAr/Vetszq+7faMvazSfYyYFHHhJlC/3M8xlT1kiXLjoZQ5
    fHGsYoTgkm8oMlAYOrHe5ulAF9exibAPsjHCTKB9M1J5vuDDcBb5+qZ4d36uLclzpF2a
    k9l0Tw9IUkkl07VtYxXBt8ExmSbU4uL9EFiSVneB6/08fc/c+BgKCPQ6fCMEHvJ7KnSb
    b/8m107uvV+s5PqvfoiL7dnT1yigmh386bNmootZtDvqXoXscsywWVaGO6SW/alW4kFv
    VCZHlyClcBr2F47JG+flpyy8Cdn8ETrp7+qN/X+odOZ3SJuYhirLSYSGa3y8eRchYOEI
    OjNg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760555118;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=8ihu2cgY7TBPXK+YLTTlEOZ5P7XCwqiL/DVyBqlxg28=;
    b=g3MrjDc3tmEc7YcQwX42lMSoD1dBsyfzozlS1eYsLPwNZ2TQpNGTfGvIMHKFmGQ77P
    Dn0Aqca/ZLL9ZWq+WvViKr2TtUvpwOluDx3USt7z9DpbeHyyE6+fqW69vyhjff9PpeDH
    +V6/AXwmEmxuVv+bcXTmvJf/6gblGnCh4QYxTvZco43r2JejQRLZWpfa8bAba3p9ANtU
    3sPveMX/EmDqOPRLIhn+dyHiXaKR2/qsMvSURGk+DTms+mNRah+/x0AzZmK4yQ7iUWPn
    XHo3HS69xQOsVPSwcQFBku0eRonODJF8RFZ34zeX6rLmKuMpOFES1s8hEA5VLQrb4Hmj
    8WCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d019FJ5IbNQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 15 Oct 2025 21:05:18 +0200 (CEST)
Message-ID: <8d6887a5-60bc-423c-8f7a-87b4ab739f6a@hartkopp.net>
Date: Wed, 15 Oct 2025 21:05:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Herve Codina <herve.codina@bootlin.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: PCI/MSI: Boot issue on X86 Laptop 6.18-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

my Lenovo V17 Gen 2 (i7-1165G7) does not boot since commit

54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")

from the beginning of the 6.18 merge window.

I've checked the discussion about the original patch "[PATCH v2 2/4] 
PCI/MSI: Add startup/shutdown for per device domains" here:

https://lore.kernel.org/all/qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s/

where a fix has been suggested (which was later applied) that doesn't 
help on my machine. So the Linus' latest tree 
6.18.0-rc1-00017-g5a6f65d15025 still does not work.

I was pretty lost when trying to follow the PCI quirk discussion about 
"[PPC] Boot problems after the pci-v6.18-changes" here:

https://lore.kernel.org/linux-pci/4rtktpyqgvmpyvars3w3gvbny56y4bayw52vwjc3my3q2hw3ew@onz4v2p2uh5i/T/#ma4425fd40ec041dcda2393a55bca5907887c2b52

Any idea how I can support you to make my machine boot again?

Thanks,
Oliver

